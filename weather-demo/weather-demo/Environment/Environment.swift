//
//  Environment.swift
//  weatherApp
//
//  Created by Artem Tselikov on 2018-06-24.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import CoreData

protocol Environment {

    var apiService: APIService { get }
    var persistentContainer: NSPersistentContainer { get }

    // TODO: maybe need to remove this
    func saveContext()

}
