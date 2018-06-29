//
//  CitySelectionViewController.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-14.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit

protocol CitySelectionDelegate: class {
    // TODO: change to city object
    func selected(city: String?)
}

class CitySelectionViewController: UIViewController {

    weak var delegate: CitySelectionDelegate? = nil

    @IBOutlet fileprivate weak var tableView: UITableView!

    fileprivate let searchController = UISearchController(searchResultsController: nil)

    fileprivate let viewModel = CitySelectionViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()

        setupTableView()
        setupSearch()
    }

    fileprivate func setupNavigationBar() {
        self.title = "Selection"
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelButton
    }

    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }

    fileprivate func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Seach city"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    @objc
    fileprivate func done() {
        viewModel.done()
        delegate?.selected(city: viewModel.selectedCity)
    }

    @objc
    fileprivate func cancel() {
        delegate?.selected(city: nil)
    }

}

extension CitySelectionViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        viewModel.selectedCity = searchController.searchBar.text
    }

}

// TODO make it using rx

extension CitySelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell", for: indexPath)

        cell.textLabel?.text = viewModel.cities[indexPath.row]

        return cell
    }

}

extension CitySelectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedCity = viewModel.cities[indexPath.row]
        done()
    }
}
