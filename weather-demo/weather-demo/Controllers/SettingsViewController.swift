//
//  SettingsViewController.swift
//  weatherApp
//
//  Created by Artem Tselikov on 2018-06-29.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit

protocol SettingsControllerDelegate: class {
    func done()
}

class SettingsViewController: UIViewController {

    weak var delegate: SettingsControllerDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    fileprivate func setupNavigationBar() {
        self.title = "Settings"
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelButton
    }

    @objc
    fileprivate func done() {
        delegate?.done()
    }

    @objc
    fileprivate func cancel() {
        delegate?.done()
    }

}
