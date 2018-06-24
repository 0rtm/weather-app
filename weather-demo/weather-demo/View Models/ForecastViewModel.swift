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
        return Observable.just(forecast.city.name)
    }

    //TODO: selectable fromatter
    fileprivate var formatter: MeasurementFormatter {
        let f = MeasurementFormatter()
        f.unitStyle = .short
        f.unitOptions = [.temperatureWithoutUnit]


        let n = NumberFormatter()
        n.maximumFractionDigits = 0

        f.numberFormatter = n
        return f
    }

    var currentTemp: Observable<String> {
        return forecast.currentTemperature.asObservable().map {[weak self] temp in

            // TODO: make configurable
            guard let t = temp?.converted(to: .celsius) else {
                return "N/A"
            }
            return self?.formatter.string(from: t) ?? "N/A"
        }
    }

    var condition: Observable<String> {
        return forecast.condition.asObservable().map { c in
            return c ?? "N/A"
        }
    }

    init(forecast aForecast: Forecast) {
        forecast = aForecast
    }

    func load() {
        forecast.loadForecast()
    }

}
