//
//  FontSelectionViewController.swift
//  TextLayout
//
//  Created by temoki on 2016/10/28.
//  Copyright © 2016年 temoki.com All rights reserved.
//

import UIKit


class FontSelectionViewController: UITableViewController {
    
    private var systemFontNames: [(name: String, display: String)] = []
    private var otherFontNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size: CGFloat = 16
        
        systemFontNames.removeAll()
        systemFontNames.append((name: UIFont.systemFont(ofSize: size).fontName, display: "Regular"))
        systemFontNames.append((name: UIFont.boldSystemFont(ofSize: size).fontName, display: "Bold"))
        systemFontNames.append((name: UIFont.italicSystemFont(ofSize: size).fontName, display: "Italic"))
        
        otherFontNames.removeAll()
        for family in UIFont.familyNames {
            for name in UIFont.fontNames(forFamilyName: family) {
                otherFontNames.append(name)
            }
        }
    }
    
    
    // MARK:- UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "System Font"
        default:
            return "Other"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return systemFontNames.count
        default:
            return otherFontNames.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath)
        
        var title = ""
        var fontName = ""
        if indexPath.section == 0 {
            let font = systemFontNames[indexPath.row]
            fontName = font.name
            title = "\(font.display) (\(fontName))"
        } else {
            fontName = otherFontNames[indexPath.row]
            title = fontName
        }
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont(name: fontName, size: cell.textLabel!.font!.pointSize)
        cell.accessoryType = fontName == Properties.shared.fontName ? .checkmark : .none
        
        return cell
    }
    
    
    // MARK:- UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            Properties.shared.fontName = systemFontNames[indexPath.row].name
        } else {
            Properties.shared.fontName = otherFontNames[indexPath.row]
        }
        tableView.reloadData()
    }
    
}
