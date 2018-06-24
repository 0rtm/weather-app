//
//  CitiesListCoordinator.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-13.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import UIKit

class CitiesListCoordinator {

    var firstController: UIViewController {
        return citiesNavigation
    }

    fileprivate let storyboard = UIStoryboard(name: "Main", bundle: nil)

    fileprivate var citiesNavigation: UINavigationController

    init() {
        
        citiesNavigation = storyboard.instantiateViewController(withIdentifier: "citiesListNavitaionController") as! UINavigationController
        citiesNavigation.title = "Cities"

        configureCitiesListController()
    }

    fileprivate func configureCitiesListController(){
        let citiesList = citiesNavigation.viewControllers.first! as! CitiesListViewController
        citiesList.delegate = self
    }

    fileprivate var citySelectionController: UINavigationController {
        let navVC = storyboard.instantiateViewController(withIdentifier: "citySelectionNanVC") as! UINavigationController
        navVC.title = "Selection"

        let selectionVC = navVC.viewControllers.first! as! CitySelectionViewController
        selectionVC.delegate = self

        return navVC
    }

    fileprivate var forecastController: ForecastViewController {
        let forecastVC = storyboard.instantiateViewController(withIdentifier: "forecastVC") as! ForecastViewController
        return forecastVC
    }
}

extension CitiesListCoordinator: CitiesListControllerDelegate {

    func selected(city: City) {
        showForcastController(for: city)
    }

    fileprivate func showForcastController(for city: City) {

        let forecastVC = forecastController
        let apiService = AppEnvironment.current.apiService
        let forecast = Forecast(city: city, apiService: apiService)
        let forecastViewModel = ForecastViewModel(forecast: forecast)
        forecastVC.viewModel = forecastViewModel

        citiesNavigation.pushViewController(forecastVC, animated: true)
    }

    func addCity() {
        citiesNavigation.present(citySelectionController, animated: true, completion: nil)
    }
}

extension CitiesListCoordinator: CitySelectionDelegate {

    func selected(city: String?) {
        citiesNavigation.dismiss(animated: true, completion: nil)
    }
}
