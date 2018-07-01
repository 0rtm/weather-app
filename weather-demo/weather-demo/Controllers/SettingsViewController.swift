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

    var viewModel: SettingsViewModel? = nil

    @IBOutlet fileprivate weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    fileprivate func setupNavigationBar() {
        self.title = "Settings"
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelButton
    }

    fileprivate func setupTableView() {

        tableView.register(SettingsSegmentTableViewCell.nib,
                           forCellReuseIdentifier: SettingsSegmentTableViewCell.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self
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

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.AvaliableSettings.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.AvaliableSettings[section].settings.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSegmentTableViewCell.reuseIdentifier, for: indexPath) as! SettingsSegmentTableViewCell

        if let setting = viewModel?.AvaliableSettings[indexPath.section].settings[indexPath.row] {
            cell.configure(for: setting)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingsSegmentTableViewCell.defaultHeight
    }
}

extension SettingsViewController: UITableViewDelegate {

}
