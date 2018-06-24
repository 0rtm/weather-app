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
    let currentTemperature: Variable<Measurement<UnitTemperature>?>
    let condition: Variable<String?>

    fileprivate let apiService: APIService

    init(city: City, apiService: APIService) {
        self.city = city
        self.apiService = apiService
        self.currentTemperature = Variable(nil)
        self.condition = Variable(nil)
    }

    func loadForecast() {
        apiService.fetchForcast(city: city) { (error, forecast) in
            guard error == nil, let measurement = forecast?.main.temperatureMeasurment else {
                return
            }
            self.currentTemperature.value = measurement
            self.condition.value = forecast?.weather.first?.description
            print(forecast ?? "Nothing")
        }
    }

}
