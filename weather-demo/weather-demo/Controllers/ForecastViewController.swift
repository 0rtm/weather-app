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

class ForecastViewController: UIViewController {

    var viewModel: ForecastViewModel? = nil

    fileprivate let disposeBag = DisposeBag()

    @IBOutlet fileprivate weak var tempLabel: UILabel!
    @IBOutlet fileprivate weak var conditionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.navigationTitle.bind(to: rx.title).disposed(by: disposeBag)
        viewModel?.currentTemp.bind(to: conditionLabel.rx.text).disposed(by: disposeBag)
        loadForecast()
    }

    func loadForecast () {
        viewModel?.load()
    }

}
