//
//  CitiesViewController.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-13.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

protocol CitiesControllerDelegate: class {
    func addCity()
    func selected(city: City)
}

class CitiesViewController: UIViewController {

    weak var delegate: CitiesControllerDelegate? = nil

    fileprivate var cities: [City] = []

    @IBOutlet weak var tableView: UITableView!

    let viewModel = CitiesViewModel()
    var fr: NSFetchedResultsController<City>?

    fileprivate let disposeBag = DisposeBag()

    fileprivate func updateCitiesList() {
        let request = NSFetchRequest<City>(entityName: "City")

        let moc = AppEnvironment.current.persistentContainer.viewContext

        cities = try! moc.fetch(request)

        for city in cities {
            city.updateCurrentWeather()
        }

        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: move to view model
        tableView.delegate = self
        tableView.dataSource = self


            let r =  NSFetchRequest<City>(entityName: "City")
            r.fetchBatchSize = 20
            r.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]



        let moc = AppEnvironment.current.persistentContainer.viewContext

        fr = NSFetchedResultsController(fetchRequest: r, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)


        fr?.delegate = self



        tableView.rx.itemSelected.asObservable()
            .subscribe(onNext: {[weak self] indexPath in

                self?.tableView.deselectRow(at: indexPath, animated: true)

                    guard let city = self?.fr?.object(at: indexPath) else {
                        return
                    }
                    self?.delegate?.selected(city: city)
                }
            ).disposed(by: disposeBag)


            try! fr?.performFetch()



        tableView.reloadData()
        //updateCitiesList()

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

extension CitiesViewController: UITableViewDelegate {

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

extension CitiesViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let section = fr?.sections?[section] else {
            return 0
        }

        return section.numberOfObjects
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)

        let c = (fr?.object(at: indexPath))!

        cell.textLabel?.text = c.name

        let temp = c.currentWeather?.temperatureInKelvins

        cell.detailTextLabel?.text = "temp: \(temp ?? 0)"
        return cell

    }

}

extension CitiesViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("wtf")
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("will")
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("did")
    }

}
