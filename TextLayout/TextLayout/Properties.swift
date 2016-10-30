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
    
    var pointSize: CGFloat = 64

    var fontName: String = UIFont.systemFont(ofSize: 32).fontName

}
