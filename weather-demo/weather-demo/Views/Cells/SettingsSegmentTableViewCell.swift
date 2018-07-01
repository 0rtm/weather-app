//
//  SettingsSwitchTableViewCell.swift
//  weatherApp
//
//  Created by Artem Tselikov on 2018-06-30.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit

protocol SegmentCellDelegate: class {
    func selectionChanged(to: SegmentedOption)
}

class SettingsSegmentTableViewCell: UITableViewCell {

    static let reuseIdentifier = "segmentCell"
    static let nib = UINib(nibName: "SettingsSegmentTableViewCell", bundle: nil)
    static let defaultHeight: CGFloat = 50.0

    weak var delegate: SegmentCellDelegate?
    fileprivate var setting: SegmentedSetting?

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var segmentControl: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        delegate = nil
        setting = nil
    }

    func configure(for setting: SegmentedSetting) {

        self.setting = setting

        titleLabel.text = setting.title

        for (index, option) in setting.options.enumerated() {

            if index < segmentControl.numberOfSegments {
                segmentControl.setTitle(option.title, forSegmentAt: index)
            } else {
                segmentControl.insertSegment(withTitle: option.title, at: index, animated: false)
            }
        }
    }

    @IBAction func selectionChanged(_ sender: Any) {
        guard let _setting = setting else {
            return
        }

        delegate?.selectionChanged(to: _setting.options[segmentControl.selectedSegmentIndex])
    }

}
