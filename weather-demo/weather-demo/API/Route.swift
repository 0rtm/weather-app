//
//  Route.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-17.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import Alamofire

typealias RequestProperties = (method: HTTPMethod, path: String, query: [String: String])

enum Route {

    case current(city: City)

    var requestProperties: RequestProperties {
        switch self {
        case .current(let city):
            return (.get, "/weather", ["q": city.name])
        }
    }

}
