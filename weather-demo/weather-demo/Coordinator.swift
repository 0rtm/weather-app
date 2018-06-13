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

    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    fileprivate lazy var tabbarController: UITabBarController = {
        let tabbar = UITabBarController()
        tabbar.viewControllers = [citiesListController]
        return tabbar
    }()

    lazy var rootViewController: UIViewController = {
        return tabbarController
    }()

    lazy var citiesListController: UIViewController = {
        return storyboard.instantiateViewController(withIdentifier: "citiesListViewController")
    }()

    init() {

    }

}
