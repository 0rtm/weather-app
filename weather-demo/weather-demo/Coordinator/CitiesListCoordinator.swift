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

//    fileprivate lazy var citiesListController: CitiesListViewController = {
//        return citiesNavigation.viewControllers.first! as! CitiesListViewController
//    }()

    fileprivate lazy var citySelectionController: UINavigationController = {
        let navVC = storyboard.instantiateViewController(withIdentifier: "citySelectionNanVC") as! UINavigationController
        navVC.title = "Selection"

        let selectionVC = navVC.viewControllers.first! as! CitySelectionViewController
        selectionVC.delegate = self

        return navVC
    }()
}

extension CitiesListCoordinator: CitiesListControllerDelegate {

    func addCity() {
        citiesNavigation.present(citySelectionController, animated: true, completion: nil)
    }
}

extension CitiesListCoordinator: CitySelectionDelegate {

    func selected(city: String?) {
        citiesNavigation.dismiss(animated: true, completion: nil)
    }
}
