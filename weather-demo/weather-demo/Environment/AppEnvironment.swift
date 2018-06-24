//
//  AppEnvironment.swift
//  weatherApp
//
//  Created by Artem Tselikov on 2018-06-24.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation

struct AppEnvironment {

    static var current: Environment {
        // This will crash when current environment is not set
        return _currentEnvironment!
    }

    fileprivate static var _currentEnvironment: Environment?

    static func setEnvironment(_ env: Environment) {
        _currentEnvironment = env
    }

}
