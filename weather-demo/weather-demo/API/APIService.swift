//
//  Request.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-17.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import Alamofire


enum APIError: Error {
    case genericError(description: String)
    case parsingError
}

//typealias decodableResponse = (Error?, Decodable?)

struct APIService {

    fileprivate let decoder = JSONDecoder()
    fileprivate let serverURL: URL
    fileprivate let APIKey: String

    init(serverURL: URL, APIKey: String) {
        self.serverURL = serverURL
        self.APIKey = APIKey
    }

    func fetchForcast(city: City, completion: @escaping (Error?, ForecastDTO?)->()) {
        request(.current(city: city), completion: completion)
    }

    fileprivate func request<T>(_ route: Route, completion: @escaping (Error?, T?)->()) where T: Decodable {
        let properties = route.requestProperties
        request(requestProperties: properties, completion: completion)
    }

    fileprivate func request<T>(requestProperties: RequestProperties, completion: @escaping (Error?, T?)->()) where T: Decodable {
        var mutableParam = requestProperties.query
        mutableParam["APPID"] = APIKey
        let url = serverURL.appendingPathComponent(requestProperties.path)
        request(url: url, params: mutableParam, completion: completion)
    }

    fileprivate func request<T>(url: URL, params: [String: Any], completion: @escaping (Error?, T?)->()) where T: Decodable {

        Alamofire.request(url, parameters: params)
            .validate()
            .responseJSON {(response) in

                switch response.result {
                case .success:

                    guard let json = response.data else {
                        completion(APIError.genericError(description: "No Data recieved"), nil)
                        return
                    }

                    do {
                        let decoded = try self.decoder.decode(T.self, from: json)
                        completion(nil, decoded)

                    } catch {
                        completion(APIError.parsingError, nil)
                    }

                case .failure(let error):
                    completion(error, nil)
                }
        }
    }

}
