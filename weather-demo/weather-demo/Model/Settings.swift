//
//  Settings.swift
//  weatherApp
//
//  Created by Artem Tselikov on 2018-06-30.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation

enum TemperatureSetting: String {
    case celsius
    case fahrenheit

    static var persistanceKey: String {
        return "com.tselikov.weather.temperature-setting"
    }
}


enum WindSpeedSetting {

}

class Settings {

    private let defaults: UserDefaults

    let notificationId = "tempChanged"

    var temperature: TemperatureSetting {

        get {
            guard let tempSetting = defaults.value(forKey: TemperatureSetting.persistanceKey) as? String,
            let s = TemperatureSetting(rawValue: tempSetting)
            else {
                return defaultTemperatureSetting()
            }
            return s
        }

        set {
            defaults.set(newValue.rawValue, forKey: TemperatureSetting.persistanceKey)
            let name = Notification.Name(notificationId)
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
            print("setting temp changed to \(newValue)")
        }


    }

    init?(defaults: UserDefaults) {
        self.defaults = defaults


//        guard let tempSetting = defaults.value(forKey: TemperatureSetting.persistanceKey) as? String,
//        let temp = TemperatureSetting(rawValue: tempSetting) else {
//            return nil
//        }
//
//        temperature = temp
    }

    // TODO:
    // Change to device locale
    fileprivate func defaultTemperatureSetting() -> TemperatureSetting {
        return .celsius
    }

    //func set

}
