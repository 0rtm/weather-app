//
//  Forecast.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-17.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import RxSwift

struct Forecast {

    let city: City
    fileprivate let apiService: APIService
    var currentTemperature: Variable<String>

    init(city: City, apiService: APIService) {
        self.city = city
        self.apiService = apiService
        self.currentTemperature = Variable("0")
    }

    func loadForecast() {
        apiService.fetchForcast(city: city) { (error, forecast) in
            guard error == nil else {
                return
            }

            self.currentTemperature.value = "\(forecast?.main.temperatureInKelvins ?? 0)"
            print(forecast ?? "Nothing")
        }
    }

}
