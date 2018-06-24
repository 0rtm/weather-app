//
//  Weather+CoreDataProperties.swift
//  weather
//
//  Created by Artem Tselikov on 2018-06-24.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var temperatureInKelvins: Double

}
