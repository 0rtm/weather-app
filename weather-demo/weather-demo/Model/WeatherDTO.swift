//
//  WeatherDTO.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-17.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation


// TODO: move to separate files
struct ForecastDTO: Decodable {
    var weather: [WeatherDTO]
    var main: MainDTO
}

// TODO: move to separate files
struct WeatherDTO: Decodable {
    let description: String
    let main: String
}

// TODO: move to separate files
struct MainDTO: Decodable {
    let temperatureInKelvins: Double

    enum CodingKeys: String, CodingKey {
        case temperatureInKelvins = "temp"
    }
}
