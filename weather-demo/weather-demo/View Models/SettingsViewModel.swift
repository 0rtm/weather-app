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

protocol SegmentedSetting {

    var title: String {get}
    var options: [SegmentedOption] {get}
    var selectedIndex: Int? { get }
    func setSelectedIndex(index: Int)

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

protocol SegmentedOption {
    var title: String {get}
}



extension TemperatureSetting: SegmentedOption {

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

    static let all: [WindSpeedOption] = [.ms, .kmh, .mph]
}


//enum UnitSettings: SegmentedSetting {
//
//    case temperature
//    case windSpeed
//
//    var title: String {
//        switch self {
//        case .temperature:
//            return "Temperature"
//        case .windSpeed:
//            return "Wind speed"
//        }
//    }
//
//    var options: [SegmentedOption] {
//        switch self {
//        case .temperature:
//            return TemperatureSetting.all
//        case .windSpeed:
//            return WindSpeedOption.all
//        }
//    }
//
//    static let all:[UnitSettings] = [.temperature, .windSpeed]
//}

enum AllSettings {
    case temperature
    case windSpeed
}

struct UnitSetting: SegmentedSetting {

    func setSelectedIndex(index: Int) {

        switch option {
        case .temperature:
            // TODO: fix
            settings.temperature = options[index] as! TemperatureSetting
        default:
            return
        }
    }

    var selectedIndex: Int? {
        switch option {
        case .temperature:
            let tmp = settings.temperature
            // TODO: make without string compare
            return options.index(where: {$0.title == tmp.title})
        default:
            return 1
        }
    }

    let title: String

    let option: AllSettings

    let options: [SegmentedOption]

    unowned let settings: Settings


}

class SettingsViewModel {

    let avaliableSettings:[SectionedSetting]

    let settings: Settings

    init () {

        settings = Settings(defaults: UserDefaults.standard)!

        let tempS = UnitSetting(title: "Temperature", option: .temperature, options: TemperatureSetting.all, settings: settings)

        let uSettings: [Setting] = [Setting.segment(setting: tempS)]//UnitSettings.all.map({ .segment(setting: $0) })

        let unitsSection = SectionedSetting(title: "Units", settings: uSettings)

        avaliableSettings = [unitsSection]
    }

    func selectionChanged(setting: SegmentedSetting, selectedIndex index: Int) {
        // save selection
        // render view

        setting.setSelectedIndex(index: index)

        //settings?.temperature =

        // render ?
    }
    
}
