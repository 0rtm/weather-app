//
//  ForecastViewController.swift
//  weather-demo
//
//  Created by Artem Tselikov on 2018-06-17.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol ForecastControllerDelegate: class {
    func showSettings()
}

class ForecastViewController: UIViewController {

    var viewModel: ForecastViewModel? = nil
    weak var delegate: ForecastControllerDelegate? = nil

    fileprivate let disposeBag = DisposeBag()

    @IBOutlet fileprivate weak var tempLabel: UILabel!
    @IBOutlet fileprivate weak var conditionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        viewModel?.navigationTitle.bind(to: rx.title).disposed(by: disposeBag)
        viewModel?.currentTemp.bind(to: tempLabel.rx.text).disposed(by: disposeBag)
        viewModel?.condition.bind(to: conditionLabel.rx.text).disposed(by: disposeBag)
        loadForecast()
    }

    fileprivate func setupNavigationBar() {
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = settingsButton
    }

    fileprivate func loadForecast () {
        viewModel?.load()
    }

    @objc
    fileprivate func openSettings() {
        delegate?.showSettings()
    }

}
