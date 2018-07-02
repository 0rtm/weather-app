//
//  SettingsViewModel.swift
//  weatherApp
//
//  Created by Artem Tselikov on 2018-06-30.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation


//TODO: make sectioned to properly handle segment controller


enum Setting {
    case segment(setting: SegmentedSetting)
    case toggle(setting: ToggleSetting)
    case button(setting: ButtonSetting)
}


struct SectionedSetting {
    let title: String
    let settings: [Setting]
}

struct SegmentedSetting {

    let title: String
    let storingKey: String
    let options: [SegmentedOption]

    func select(option: SegmentedOption) {
        //TODO: move out of here and properly inject
        UserDefaults.standard.set(option.storageValue, forKey: storingKey)
    }

    func selectedOptionIndex() -> Array<SegmentedOption>.Index? {
        guard let value = UserDefaults.standard.value(forKey: storingKey) as? String else {
            return nil
        }
        return options.index(where: { $0.storageValue == value})
    }
}

struct ToggleSetting {
    let title: String

    func toggle() {

    }
}

//TODO: rename/remove
struct ButtonSetting {
    let title: String

    func action() {

    }
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

    var storageValue: String {get}

    func saveSelection(option: SegmentedOption)
}

enum TemperatureOption: SegmentedOption {
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

    var storageValue: String {
        return title
    }

    func saveSelection(option: SegmentedOption) {

    }

    static let all: [TemperatureOption] = [.celsius, .fahrenheit]
}

enum WindSpeedOption: SegmentedOption {

    case ms
    case kmh
    case mph

    var title: String {
        switch self {
        case .ms:
            return "m/s"
        case .kmh:
            return "km/h"
        case .mph:
            return "mp/h"
        }
    }

    var storageValue: String {
        return title
    }

    func saveSelection(option: SegmentedOption) {
        print("will save")
    }

    static let all: [WindSpeedOption] = [.ms, .kmh, .mph]
}


struct TemperatureSetting {

    let options = TemperatureOption.all

    var selectedOption: SegmentedOption {
        return options.first!
    }

}


class SettingsViewModel {

    let avaliableSettings:[SectionedSetting]

    let settings = Settings()

    init () {

        let temperatureSettings = SegmentedSetting(title: "Temperature",
                                                   storingKey: "com.tselikov.weather.temperatureUnits",
                                                   options: TemperatureOption.all)

        let windSpeedSetting = SegmentedSetting(title: "Wind speed",
                                                storingKey: "com.tselikov.weather.windSpeedUnits",
                                                options: WindSpeedOption.all)

        let uSettings:[Setting] = [.segment(setting: temperatureSettings), .segment(setting: windSpeedSetting)]

        let unitsSection = SectionedSetting(title: "Units", settings: uSettings)

        avaliableSettings = [unitsSection]
    }

    func selectionChanged(setting: SegmentedSetting, selectedOption option: SegmentedOption) {
        // save selection
        // render view
        setting.select(option: option)
        // render ?
    }
    
}
