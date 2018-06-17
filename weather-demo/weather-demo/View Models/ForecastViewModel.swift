//
//  ForecastViewModel.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-17.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import RxSwift

class ForecastViewModel {

    fileprivate let forecast: Forecast

    var navigationTitle: Observable<String> {
        return Observable.just(forecast.city.name ?? "No name")
    }

    init(forecast: Forecast) {
        self.forecast = forecast
    }

    func load() {
        forecast.loadForecast()
    }

}
