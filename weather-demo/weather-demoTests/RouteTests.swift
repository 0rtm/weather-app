//
//  RouteTests.swift
//  weather-demoTests
//
//  Created by Artem Tselikov on 2018-06-24.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import XCTest
import CoreData

@testable import weatherApp

class RouteTests: XCTestCase {

    var city: City? = nil

    lazy var persistenContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "weather_demo")
        try! container.persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        return container

    }()

    override func setUp() {
        super.setUp()
        let moc = persistenContainer.viewContext
        city = City(context: moc)
        city?.name = "Moscow"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testForecastRouteHasCorrectRequestParams() {

        guard let _city = city else {
            XCTFail()
            return
        }
        let route = Route.current(city: _city)

        let properties = route.requestProperties

        XCTAssertEqual(properties.method, .get)
        XCTAssertEqual(properties.path, "/weather")

        let query = ["q":_city.name]
        XCTAssertEqual(properties.query, query)
    }
    
}
