//
//  FontSelectionViewController.swift
//  TextLayout
//
//  Created by temoki on 2016/10/28.
//  Copyright © 2016年 temoki.com All rights reserved.
//

import UIKit


class FontSelectionViewController: UITableViewController {
    
    private let systemFonts: [Properties.FontType] = [.systemNormal, .systemBold, .systemItalic]
    private var otherFontNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otherFontNames.removeAll()
        for family in UIFont.familyNames {
            for name in UIFont.fontNames(forFamilyName: family) {
                otherFontNames.append(name)
            }
        }
        otherFontNames.sort()
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
            return systemFonts.count
        default:
            return otherFontNames.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath)
        
        let fontSize = cell.textLabel?.font?.pointSize ?? 17
        if indexPath.section == 0 {
            let systemFont = systemFonts[indexPath.row]
            cell.textLabel?.text = systemFont.displayName
            cell.textLabel?.font = systemFont.font(ofSize: fontSize)
            cell.accessoryType = Properties.shared.fontType.equals(toType: systemFont) ? .checkmark : .none
        } else {
            let fontName = otherFontNames[indexPath.row]
            cell.textLabel?.text = fontName
            cell.textLabel?.font = UIFont(name: fontName, size: fontSize)
            cell.accessoryType = Properties.shared.fontType.equals(toName: fontName) ? .checkmark : .none
        }
        
        return cell
    }
    
    
    // MARK:- UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            Properties.shared.fontType = systemFonts[indexPath.row]
        } else {
            Properties.shared.fontType = Properties.FontType.other(otherFontNames[indexPath.row])
        }
        tableView.reloadData()
    }
    
}
