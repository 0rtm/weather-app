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

    fileprivate let storyboard = UIStoryboard(name: "Main", bundle: nil)

    fileprivate lazy var tabbarController: UITabBarController = {
        let tabbar = UITabBarController()
        tabbar.viewControllers = [citiesNavigation]
        return tabbar
    }()

    lazy var rootViewController: UIViewController = {
        return tabbarController
    }()

    fileprivate lazy var citiesNavigation: UINavigationController = {
        let navVC = storyboard.instantiateViewController(withIdentifier: "citiesListNavitaionController") as! UINavigationController
        navVC.title = "Cities"
        return navVC
    }()

    fileprivate lazy var citiesListController: UIViewController = {
        return citiesNavigation.viewControllers.first!
    }()

    init() {

    }

}
