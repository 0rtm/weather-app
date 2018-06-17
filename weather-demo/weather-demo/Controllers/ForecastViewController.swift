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
import Alamofire

class ForecastViewController: UIViewController {

    var viewModel: ForecastViewModel? = nil

    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.navigationTitle.bind(to: rx.title).disposed(by: disposeBag)
        loadForecast()
    }


    func loadForecast () {
        //let cityName = viewModel.ci
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=toronto&apikey=9397aff5413f75e8c682ac94c9938a8e") else {
            return
        }
        Alamofire.request(url).responseJSON {[weak self] (response) in
            print(response)
        }
    }

}
