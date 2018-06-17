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

    fileprivate let city: City

    var navigationTitle: Observable<String> {
        return Observable.just(city.name ?? "No name")
    }


    init(city: City) {
        self.city = city
    }

}
