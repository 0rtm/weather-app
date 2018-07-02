//
//  SettingsSwitchTableViewCell.swift
//  weatherApp
//
//  Created by Artem Tselikov on 2018-06-30.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import UIKit

protocol SegmentCellDelegate: class {
    func selectionChanged(setting: SegmentedSetting, selectedIndex index: Int)
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

    func configure(for setting: Setting) {

        switch setting {
        case .segment(let s):
            configure(for: s)
        default:
            return
        }
    }

    fileprivate func configure(for setting: SegmentedSetting) {
        self.setting = setting

        titleLabel.text = setting.title

        let selectedIndex = setting.selectedIndex

        for (index, option) in setting.options.enumerated() {

            if index < segmentControl.numberOfSegments {
                segmentControl.setTitle(option.title, forSegmentAt: index)
            } else {
                segmentControl.insertSegment(withTitle: option.title, at: index, animated: false)
            }

            if index == selectedIndex {
                segmentControl.selectedSegmentIndex = index
            }
        }
    }
    

    @IBAction func selectionChanged(_ sender: Any) {
        guard let _setting = setting else {
            return
        }

        delegate?.selectionChanged(setting: _setting, selectedIndex: segmentControl.selectedSegmentIndex)
    }

}
