//
//  Properties.swift
//  TextLayout
//
//  Created by temoki on 2016/10/29.
//  Copyright © 2016年 temoki.com. All rights reserved.
//

import UIKit

class Properties {
    
    static let shared = Properties()
    
    // MARK:- For UILabel
    
    static let textList = [
         "jKf"
        ,"Jump 跳ぶ Fly 飛ぶ"
        ,"The quick brown fox jumps over the lazy dog"
        ,"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        ,"abcdefghijklmnopqrstuvwxyz"
        ,"あのイーハトーヴォのすきとおった風、夏でも底に冷たさをもつ青いそら"
        ,"あかさたなはまやらわ"
        ,"アカサタナハマヤラワ"
    ]
    
    enum TextType {
        case preset(Int) // textList index
        case custom(String)
    }
    
    var textType: TextType = .preset(0)
    
    var text: String {
        get {
            switch textType {
            case .preset(let index):
                return Properties.textList[index]
            case .custom(let text):
                return text
            }
        }
    }
    
    
    // MARK:- For UIFont
    
    enum FontType {
        case systemNormal
        case systemBold
        case systemItalic
        case other(String) // font name
        
        func font(ofSize: CGFloat) -> UIFont {
            switch self {
            case .systemNormal:
                return UIFont.systemFont(ofSize: ofSize)
            case .systemBold:
                return UIFont.boldSystemFont(ofSize: ofSize)
            case .systemItalic:
                return UIFont.italicSystemFont(ofSize: ofSize)
            case .other(let name):
                return UIFont(name: name, size: ofSize)!
            }
        }
        
        var displayName: String {
            switch self {
            case .systemNormal:
                return "System Regular"
            case .systemBold:
                return "System Bold"
            case .systemItalic:
                return "System Italic"
            case .other(_):
                return self.font(ofSize: 32).fontName
            }
        }
        
        func detailDescription(ofSize size: CGFloat) -> String {
            switch self {
            case .systemNormal, .systemBold, .systemItalic:
                return "\(self.displayName) - \(self.font(ofSize: size).fontName)"
            case .other(let name):
                return name
            }
        }
        
        func equals(toType type: FontType) -> Bool {
            if case FontType.systemNormal = self {
                if case FontType.systemNormal = type { return true }
            } else if case FontType.systemBold = self {
                if case FontType.systemBold = type { return true }
            } else if case FontType.systemItalic = self {
                if case FontType.systemItalic = type { return true }
            }
            switch self {
            case .other(let name):
                if case FontType.other(name) = type {
                    return true
                }
            default:
                break
            }
            return false
        }
        
        func equals(toName name: String) -> Bool {
            switch self {
            case .other(let selfName):
                return selfName == name
            default:
                return false
            }
        }

    }

    var fontType: FontType = .systemNormal

    var pointSize: CGFloat = 64
    

    
    // MARK:- For NSParagraphStype
    
    var lineSpacing: CGFloat?
    
    var lineHeightMultiple: CGFloat?
    
    var maximumLineHeight: CGFloat?

    var minimumLineHeight: CGFloat?
    
}
