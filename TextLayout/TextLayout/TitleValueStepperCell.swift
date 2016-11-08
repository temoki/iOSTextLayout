//
//  TitleValueStepperCell.swift
//  TextLayout
//
//  Created by temoki on 2016/10/29.
//  Copyright © 2016年 temoki.com. All rights reserved.
//

import UIKit

class TitleValueStepperCell: UITableViewCell {
    
    static let identifier = "TitleValueStepperCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var enableSwitch: UISwitch!
    @IBOutlet weak var valueStepper: UIStepper!
    
    var value: CGFloat {
        set {
            valueStepper.value = Double(newValue)
            valueLabel.text = "\(newValue)"
        }
        get {
            return CGFloat(valueStepper.value)
        }
    }
    
    var isEnabled: Bool {
        set {
            enableSwitch.isOn = newValue
            updateState()
        }
        get {
            return enableSwitch.isOn
        }
    }
    
    enum ChangedState {
        case isEnabled
        case value
    }
    
    var valueChangedHandler: ((TitleValueStepperCell, ChangedState) -> Void)?
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        updateState()
        valueChangedHandler?(self, .isEnabled)
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        valueLabel.text = "\(value)"
        valueChangedHandler?(self, .value)
    }
    
    private func updateState() {
        valueStepper.isHidden = !enableSwitch.isOn
        valueLabel.isHidden = !enableSwitch.isOn
    }

}
