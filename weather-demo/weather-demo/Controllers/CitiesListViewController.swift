//
//  CitiesListViewController.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-13.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit
import CoreData

protocol CitiesListControllerDelegate: class {
    func addCity()
}

class CitiesListViewController: UIViewController {

    weak var delegate: CitiesListControllerDelegate? = nil

    fileprivate var cities: [City] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: move to view model
        tableView.delegate = self
        tableView.dataSource = self


        let request = NSFetchRequest<City>(entityName: "City")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc = appDelegate.persistentContainer.viewContext

        cities = try! moc.fetch(request)
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction fileprivate func add(_ sender: Any) {
        self.delegate?.addCity()
    }
    
}

extension CitiesListViewController: UITableViewDelegate {

}

extension CitiesListViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = cities[indexPath.row].name
        return cell

    }

}
