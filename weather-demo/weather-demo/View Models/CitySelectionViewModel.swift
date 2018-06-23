//
//  CitySelectionViewModel.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-16.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit

class CitySelectionViewModel {

    // When we will have a list of cities
    // make table view and so on

    let cities = ["Toronto", "Moscow", "London"]


    var selectedCity: String?

    func done() {
        // save to core data

        guard let cityName = selectedCity else {
            return
        }

        let delegate = UIApplication.shared.delegate as! AppDelegate
        let moc = delegate.persistentContainer.viewContext


        let city = City(context: moc)
        city.name = cityName

        try? moc.save()
    }

}
