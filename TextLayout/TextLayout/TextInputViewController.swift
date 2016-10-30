//
//  TextInputViewController.swift
//  TextLayout
//
//  Created by temoki on 2016/10/29.
//  Copyright © 2016年 temoki.com All rights reserved.
//

import UIKit


class TextInputViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK:- UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Preset"
        default:
            return "Custom"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Properties.textList.count
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = Properties.textList[indexPath.row]
            cell.selectionStyle = .default
            switch Properties.shared.textType {
            case .preset(let index):
                cell.accessoryType = index == indexPath.row ? .checkmark : .none
            case .custom(_):
                cell.accessoryType = .none
            }
        } else {
            switch Properties.shared.textType {
            case .preset(_):
                cell.textLabel?.text = nil
                cell.selectionStyle = .default
                cell.accessoryType = .disclosureIndicator
            case .custom(let text):
                cell.textLabel?.text = text
                cell.selectionStyle = .default
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    
    // MARK:- UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            selectText(index: indexPath.row)
        } else {
            inputText()
        }
    }
    
    // Private
    
    private func selectText(index: Int) {
        Properties.shared.textType = .preset(index)
        tableView.reloadData()
    }
    
    private func inputText() {
        let alert = UIAlertController(title: "Text", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
            if let text = alert.textFields?.first?.text {
                Properties.shared.textType = .custom(text)
                self?.tableView.reloadData()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
