//
//  CitiesListViewController.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-13.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

protocol CitiesListControllerDelegate: class {
    func addCity()
    func selected(city: City)
}

class CitiesListViewController: UIViewController {

    weak var delegate: CitiesListControllerDelegate? = nil

    fileprivate var cities: [City] = []

    @IBOutlet weak var tableView: UITableView!

    fileprivate let disposeBag = DisposeBag()

    fileprivate func updateCitiesList() {
        let request = NSFetchRequest<City>(entityName: "City")

        let moc = AppEnvironment.current.persistentContainer.viewContext

        cities = try! moc.fetch(request)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: move to view model
        tableView.delegate = self
        tableView.dataSource = self

        tableView.rx.itemSelected.asObservable()
            .subscribe(onNext: {[weak self] indexPath in

                self?.tableView.deselectRow(at: indexPath, animated: true)

                    guard let city = self?.cities[indexPath.row] else {
                        return
                    }
                    self?.delegate?.selected(city: city)
                }
            ).disposed(by: disposeBag)


        updateCitiesList()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCitiesList()
    }

    @IBAction fileprivate func add(_ sender: Any) {
        self.delegate?.addCity()
    }

    // TODO: move to view model
    fileprivate func delete(city: City?) {
        guard let _city = city else { return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc = AppEnvironment.current.persistentContainer.viewContext
        moc.delete(_city)

        do {
            try moc.save()
        } catch {
        }

        updateCitiesList()
    }
}

extension CitiesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {[weak self] (action, view, success) in
            self?.delete(city: self?.cities[indexPath.row])
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

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
