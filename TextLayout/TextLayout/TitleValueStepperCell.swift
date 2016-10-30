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
    
    var valueChangedHandler: ((CGFloat) -> Void)?
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        valueChangedHandler?(value)
        valueLabel.text = "\(value)"
    }
    
}
