//
//  SettingsViewModel.swift
//  weatherApp
//
//  Created by Artem Tselikov on 2018-06-30.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation


//TODO: make sectioned to properly handle segment controller


enum SettingSection {
    case measurement

    var settings: [SegmentedSetting] {
        switch self {
        case .measurement:
            let temperatureSettings = SegmentedSetting(title: "Temperature", options: TemperatureSetting.all)
            return [temperatureSettings]
        }
    }
}

struct SegmentedSetting {
    let title: String
    let options: [SegmentedOption]
}



//enum SegmentedSetting {
//    case temperature
//    case windSpeed
//
//    var title: String {
//        switch self {
//        case .temperature:
//            return "Temperature"
//        case .windSpeed:
//            return "Wind Speed"
//        }
//    }
//
//    var options: [String] {
//        switch self {
//        case .temperature:
//            return ["Celsius", ]
//        case .windSpeed:
//            return ["m/s", "km/h", "mp/h"]
//        }
//    }
//}

protocol SegmentedOption {
    var title: String {get}
}

enum TemperatureSetting: SegmentedOption {
    case celsius
    case fahrenheit

    var title: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        }
    }

    static let all: [TemperatureSetting] = [.celsius, .fahrenheit]
}

class SettingsViewModel {
    let AvaliableSettings = [SettingSection.measurement]

    let settings = Settings()

    
}
