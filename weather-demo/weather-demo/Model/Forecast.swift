//
//  Forecast.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-17.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation

struct Forecast {

    let city: City
    fileprivate let apiService: APIService

    init(city: City, apiService: APIService) {
        self.city = city
        self.apiService = apiService
    }

    func loadForecast() {
        apiService.fetchForcast(city: city) { (error, forecast) in
            guard error == nil else {
                return
            }
            print(forecast ?? "Nothing")
        }
    }

}
