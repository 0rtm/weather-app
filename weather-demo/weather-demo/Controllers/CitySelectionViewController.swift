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

    fileprivate let searchController = UISearchController(searchResultsController: nil)

    fileprivate let viewModel = CitySelectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
    }

    @IBAction func done(_ sender: Any) {
        viewModel.selectedCity = "London"
        viewModel.done()
        delegate?.selected(city: viewModel.selectedCity)
    }

    @IBAction func cancel(_ sender: Any) {
        delegate?.selected(city: nil)
    }
    
    fileprivate func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Seach city"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension CitySelectionViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        viewModel.selectedCity = searchController.searchBar.text
    }

}
