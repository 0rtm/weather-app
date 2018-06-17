//
//  Coordinator.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-13.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import UIKit

final class Coordinator {

    fileprivate let citiesCoordinator: CitiesListCoordinator

    fileprivate lazy var tabbarController: UITabBarController = {
        let tabbar = UITabBarController()
        tabbar.viewControllers = [citiesCoordinator.firstController]
        return tabbar
    }()

    lazy var rootViewController: UIViewController = {
        return tabbarController
    }()

    init() {
        self.citiesCoordinator = CitiesListCoordinator()
    }

}
