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

        configureCitiesController()
    }

    fileprivate func configureCitiesController(){
        let citiesList = citiesNavigation.viewControllers.first! as! CitiesViewController
        citiesList.delegate = self
    }

    fileprivate var citySelectionNC: UINavigationController {
        let selectionVC = storyboard.instantiateViewController(withIdentifier: "citySelectionVC") as! CitySelectionViewController
        selectionVC.delegate = self

        let nav = UINavigationController()
        nav.viewControllers = [selectionVC]
        return nav
    }

    fileprivate var forecastController: ForecastViewController {
        let forecastVC = storyboard.instantiateViewController(withIdentifier: "forecastVC") as! ForecastViewController
        return forecastVC
    }

    fileprivate var settingsNC: UINavigationController {
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "settingsVC") as! SettingsViewController
        settingsVC.delegate = self

        let nav = UINavigationController()
        nav.viewControllers = [settingsVC]

        return nav
    }
}

extension CitiesListCoordinator: CitiesControllerDelegate {

    func selected(city: City) {
        showForcastController(for: city)
    }

    fileprivate func showForcastController(for city: City) {
        let forecastVC = forecastController
        let apiService = AppEnvironment.current.apiService
        let forecast = Forecast(city: city, apiService: apiService)
        let forecastViewModel = ForecastViewModel(forecast: forecast)
        forecastVC.viewModel = forecastViewModel
        forecastVC.delegate = self
        citiesNavigation.pushViewController(forecastVC, animated: true)
    }

    func addCity() {
        citiesNavigation.present(citySelectionNC, animated: true, completion: nil)
    }
}

extension CitiesListCoordinator: CitySelectionDelegate {

    func selected(city: String?) {
        citiesNavigation.dismiss(animated: true, completion: nil)
    }
}

extension CitiesListCoordinator: ForecastControllerDelegate {

    func showSettings() {
        let settings = settingsNC
        citiesNavigation.present(settings, animated: true, completion: nil)
    }

}

extension CitiesListCoordinator: SettingsControllerDelegate {

    func done() {
        citiesNavigation.dismiss(animated: true, completion: nil)
    }

}
