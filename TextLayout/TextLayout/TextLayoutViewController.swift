//
//  ViewController.swift
//  TextLayout
//
//  Created by temoki on 2016/10/28.
//  Copyright © 2016年 temoki.com All rights reserved.
//

import UIKit



class TextLayoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let textInputSegue = "TextInputSegue"
    private let fontSelectionSegue = "FontSelectionSegue"
    
    @IBOutlet weak var textLabel: GuideLabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    

    // MARK:- Private
    
    private func update() {
        let p = Properties.shared
        if p.lineSpacing != nil || p.lineHeightMultiple != nil || p.maximumLineHeight != nil || p.minimumLineHeight != nil {
            // NSParagraphStyle の設定が１つでも有効の場合は .attributedText を設定
            var attributes: [String: Any] = [:]
            
            let text = NSMutableAttributedString(string: p.text)
            let range = NSRange(location: 0, length: text.length)
            
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            paragraph.lineHeightMultiple = p.lineHeightMultiple ?? NSParagraphStyle.default.lineHeightMultiple
            paragraph.lineSpacing = p.lineSpacing ?? NSParagraphStyle.default.lineSpacing
            paragraph.maximumLineHeight = p.maximumLineHeight ?? NSParagraphStyle.default.maximumLineHeight
            paragraph.minimumLineHeight = p.minimumLineHeight ?? NSParagraphStyle.default.minimumLineHeight
            attributes[NSParagraphStyleAttributeName] = paragraph
            
            if let font = UIFont(name: p.fontName, size: p.pointSize) {
                attributes[NSFontAttributeName] = font
            }
            
            text.addAttributes(attributes, range: range)
            textLabel.attributedText = text
            
        } else {
            // NSParagraphStyle の設定が全て無効の場合は通常の .text/.font を設定
            textLabel.text = Properties.shared.text
            textLabel.font = UIFont(name: Properties.shared.fontName, size: Properties.shared.pointSize)
        }
        
        tableView.reloadData()
    }
    
    
    // MARK:- UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "UILabel"
        case 1:
            return "UIFont"
        case 2:
            return "NSParagraphStyle"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 8
        case 2:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let font = textLabel.font!
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".text"
                cell.titleLabel.textColor = UIColor.black
                cell.detailLabel.text = textLabel?.text ?? ""
                cell.selectionStyle = .default
                cell.accessoryType = .disclosureIndicator
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".bounds.size"
                cell.titleLabel.textColor = GuideLabel.colorBounds
                cell.detailLabel.text = "w: \(textLabel.bounds.width), h: \(textLabel.bounds.height)"
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            default:
                break
            }

        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".fontName"
                cell.titleLabel.textColor = UIColor.black
                cell.detailLabel.text = font.fontName
                cell.selectionStyle = .default
                cell.accessoryType = .disclosureIndicator
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleValueStepperCell.identifier, for: indexPath) as! TitleValueStepperCell
                cell.titleLabel.text = ".pointSize"
                cell.titleLabel.textColor = UIColor.black
                cell.value = Properties.shared.pointSize
                cell.isEnabled = true
                cell.enableSwitch.isHidden = true
                cell.valueStepper.stepValue = 1
                cell.valueChangedHandler = { [weak self] (cell, state) in
                    Properties.shared.pointSize = cell.value
                    self?.update()
                }
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".lineHeight"
                switch textLabel.suitableLineHeight {
                case .normal(_):
                    cell.titleLabel.textColor = GuideLabel.colorLineHeight
                default:
                    cell.titleLabel.textColor = UIColor.black
                }
                cell.detailLabel.text = "\(font.lineHeight)"
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".ascender"
                cell.titleLabel.textColor = GuideLabel.colorAscender
                cell.detailLabel.text = "\(font.ascender)"
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".descender"
                cell.titleLabel.textColor = GuideLabel.colorDescender
                cell.detailLabel.text = "\(font.descender)"
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".capHeight"
                cell.titleLabel.textColor = GuideLabel.colorCapHeight
                cell.detailLabel.text = "\(font.capHeight)"
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".xHeight"
                cell.titleLabel.textColor = GuideLabel.colorXHeight
                cell.detailLabel.text = "\(font.xHeight)"
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".leading"
                cell.titleLabel.textColor = UIColor.black
                cell.detailLabel.text = "\(font.leading)"
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            default:
                break
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleValueStepperCell.identifier, for: indexPath) as! TitleValueStepperCell
                cell.titleLabel.text = ".lineSpacing"
                cell.titleLabel.textColor = UIColor.black
                if let value = Properties.shared.lineSpacing {
                    cell.isEnabled = true
                    cell.value = value
                } else {
                    cell.isEnabled = false
                    cell.value = NSParagraphStyle.default.lineSpacing
                }
                cell.enableSwitch.isHidden = false
                cell.valueStepper.stepValue = 1
                cell.valueChangedHandler = { [weak self] (cell, _) in
                    Properties.shared.lineSpacing = cell.isEnabled ? cell.value : nil
                    self?.update()
                }
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleValueStepperCell.identifier, for: indexPath) as! TitleValueStepperCell
                cell.titleLabel.text = ".lineHeightMultiple"
                switch textLabel.suitableLineHeight {
                case .multiple(_):
                    cell.titleLabel.textColor = GuideLabel.colorLineHeight
                default:
                    cell.titleLabel.textColor = UIColor.black
                }
                if let value = Properties.shared.lineHeightMultiple {
                    cell.isEnabled = true
                    cell.value = value
                } else {
                    cell.isEnabled = false
                    cell.value = NSParagraphStyle.default.lineHeightMultiple
                }
                cell.enableSwitch.isHidden = false
                cell.valueStepper.stepValue = 0.1
                cell.valueChangedHandler = { [weak self] (cell, state) in
                    switch state {
                    case .isEnabled:
                        if cell.isEnabled {
                            Properties.shared.lineHeightMultiple = 1
                            Properties.shared.maximumLineHeight = nil
                            Properties.shared.minimumLineHeight = nil
                        } else {
                            Properties.shared.lineHeightMultiple = nil
                        }
                    case .value:
                        if cell.isEnabled {
                            Properties.shared.lineHeightMultiple = cell.value
                        }
                    }
                    self?.update()
                }
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleValueStepperCell.identifier, for: indexPath) as! TitleValueStepperCell
                cell.titleLabel.text = ".maximumLineHeight"
                switch textLabel.suitableLineHeight {
                case .maximum(_):
                    cell.titleLabel.textColor = GuideLabel.colorLineHeight
                default:
                    cell.titleLabel.textColor = UIColor.black
                }
                if let value = Properties.shared.maximumLineHeight {
                    cell.isEnabled = true
                    cell.value = value
                } else {
                    cell.isEnabled = false
                    cell.value = NSParagraphStyle.default.maximumLineHeight
                }
                cell.enableSwitch.isHidden = false
                cell.valueStepper.stepValue = 1
                cell.valueChangedHandler = { [weak self] (cell, state) in
                    switch state {
                    case .isEnabled:
                        if cell.isEnabled {
                            Properties.shared.maximumLineHeight = font.lineHeight
                            Properties.shared.lineHeightMultiple = nil
                        } else {
                            Properties.shared.maximumLineHeight = nil
                        }
                    case .value:
                        if cell.isEnabled {
                            Properties.shared.maximumLineHeight = cell.value
                        }
                    }
                    self?.update()
                }
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleValueStepperCell.identifier, for: indexPath) as! TitleValueStepperCell
                cell.titleLabel.text = ".minimumLineHeight"
                switch textLabel.suitableLineHeight {
                case .minimum(_):
                    cell.titleLabel.textColor = GuideLabel.colorLineHeight
                default:
                    cell.titleLabel.textColor = UIColor.black
                }
                if let value = Properties.shared.minimumLineHeight {
                    cell.isEnabled = true
                    cell.value = value
                } else {
                    cell.isEnabled = false
                    cell.value = NSParagraphStyle.default.minimumLineHeight
                }
                cell.enableSwitch.isHidden = false
                cell.valueStepper.stepValue = 1
                cell.valueChangedHandler = { [weak self] (cell, state) in
                    switch state {
                    case .isEnabled:
                        if cell.isEnabled {
                            Properties.shared.minimumLineHeight = font.lineHeight
                            Properties.shared.lineHeightMultiple = nil
                        } else {
                            Properties.shared.minimumLineHeight = nil
                        }
                    case .value:
                        if cell.isEnabled {
                            Properties.shared.minimumLineHeight = cell.value
                        }
                    }
                    self?.update()
                }
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            default:
                break
            }
        }
        return tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
    }
    
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                performSegue(withIdentifier: textInputSegue, sender: nil)
            default:
                break
            }

        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                performSegue(withIdentifier: fontSelectionSegue, sender: nil)
            default:
                break
            }
        }
    }
    
}

