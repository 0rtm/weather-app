//
//  ConfigurableEnvironment.swift
//  weatherApp
//
//  Created by Artem Tselikov on 2018-06-24.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import CoreData

struct ConfigurableEnvironment: Environment {

    let apiService: APIService

    let persistentContainer: NSPersistentContainer

    init(apiService: APIService, persistentContainer: NSPersistentContainer) {
        self.apiService = apiService
        self.persistentContainer = persistentContainer
    }

    func saveContext() {}
}


