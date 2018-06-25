//
//  City.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-22.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//
//

import Foundation
import CoreData

@objc (City)
public class City: NSManagedObject {

}

extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String
    @NSManaged public var currentWeather: Weather?

}

extension City {

    func updateCurrentWeather() {

        AppEnvironment.current.apiService.fetchForcast(city: self) {[weak self] (error, forecast) in

            guard error == nil, let _forecast = forecast else {
                return
            }

            let moc = AppEnvironment.current.persistentContainer.viewContext

            let newTemp = _forecast.main.temperatureInKelvins

            if let currentW = self?.currentWeather {
                currentW.temperatureInKelvins = newTemp
            } else {
                let w = Weather(context: moc)
                w.temperatureInKelvins = newTemp
                self?.currentWeather = w
            }

            AppEnvironment.current.saveContext()
        }

    }

}
