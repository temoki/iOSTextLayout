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
        textLabel.text = Properties.shared.text
        textLabel.font = UIFont(name: Properties.shared.fontName, size: Properties.shared.pointSize)
        tableView.reloadData()
    }
    
    
    // MARK:- UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "UILabel"
        case 1:
            return "UIFont"
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
                cell.titleLabel.text = ".bounds.height"
                cell.titleLabel.textColor = UIColor.black
                cell.detailLabel.text = "\(textLabel.bounds.height)"
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
                cell.valueChangedHandler = { [weak self] (value) in
                    Properties.shared.pointSize = value
                    self?.update()
                }
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier, for: indexPath) as! TitleDetailCell
                cell.titleLabel.text = ".lineHeight"
                cell.titleLabel.textColor = GuideLabel.colorLineHeight
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

