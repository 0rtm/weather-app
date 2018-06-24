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


public class City: NSManagedObject {

}

extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String

}
