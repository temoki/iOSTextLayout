//
//  GuideLabel.swift
//  TextLayout
//
//  Created by temoki on 2016/10/28.
//  Copyright © 2016年 temoki.com. All rights reserved.
//

import UIKit

class GuideLabel: UILabel {
    
    static let colorLineHeight = UIColor.red
    static let colorAscender = UIColor.green
    static let colorDescender = UIColor.blue
    static let colorCapHeight = UIColor.orange
    static let colorXHeight = UIColor.purple
    
    enum SuitableLineHeight {
        case normal(CGFloat)
        case multiple(CGFloat)
        case maximum(CGFloat)
        case minimum(CGFloat)
        
        var value: CGFloat {
            switch self {
            case .normal(let v), .multiple(let v), .minimum(let v), .maximum(let v):
                return v
            }
        }
    }
    
    var suitableLineHeight: SuitableLineHeight {
        if let minimum = Properties.shared.minimumLineHeight, let maximum = Properties.shared.maximumLineHeight {
            if font.lineHeight < minimum && font.lineHeight < maximum {
                return minimum > maximum ? .maximum(maximum) : .minimum(minimum)
            }
        }
        if let minimum = Properties.shared.minimumLineHeight {
            if font.lineHeight < minimum {
                return .minimum(minimum)
            }
        }
        if let maximum = Properties.shared.maximumLineHeight {
            if font.lineHeight > maximum {
                return .maximum(maximum)
            }
        }
        if let multiple = Properties.shared.lineHeightMultiple {
            if Properties.shared.maximumLineHeight == nil && Properties.shared.minimumLineHeight == nil {
                return .multiple(font.lineHeight * multiple)
            }
        }
        return .normal(font.lineHeight)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(), let font = self.font else {
            return
        }
        
        // Draw Background
        do {
            context.saveGState()
            UIColor.gray.withAlphaComponent(0.1).setFill()
            context.fill(rect)
            context.restoreGState()
        }

        // Draw UILabel
        super.draw(rect)
        
        
        // Draw Guides
        let lineHeight = suitableLineHeight.value
        let lineSpace = Properties.shared.lineSpacing ?? 0
        let baseLine = lineHeight + font.descender
        let ascenderTop = baseLine - font.ascender
        let descenderBottom = lineHeight
        let capHeightTop = baseLine - font.capHeight
        let xHeightTop = baseLine - font.xHeight
        
        let hlineWidth: CGFloat = 0.5
        let vlineWidth: CGFloat = 3
        
        let lineCount = Int((rect.size.height / lineHeight) * 1.1)
        for i in 0 ..< lineCount {
            let v = (lineHeight + lineSpace) * CGFloat(i)
            var h = rect.minX + vlineWidth / 2
            
            // Line height
            do {
                context.saveGState()
                UIColor.black.setStroke()
                context.setLineWidth(hlineWidth)
                context.move(to: CGPoint(x: h, y: v))
                context.addLine(to: CGPoint(x: rect.maxX, y: v))
                context.strokePath()
                context.restoreGState()
            }
            do {
                context.saveGState()
                UIColor.black.setStroke()
                context.setLineWidth(hlineWidth)
                context.move(to: CGPoint(x: h, y: v + lineHeight))
                context.addLine(to: CGPoint(x: rect.maxX, y: v + lineHeight))
                context.strokePath()
                context.restoreGState()
            }
            do {
                context.saveGState()
                GuideLabel.colorLineHeight.setStroke()
                context.setLineWidth(vlineWidth)
                context.move(to: CGPoint(x: h, y: v))
                context.addLine(to: CGPoint(x: h, y: v + lineHeight))
                context.strokePath()
                context.restoreGState()
            }
            
            h += vlineWidth

            // Base line
            do {
                context.saveGState()
                UIColor.gray.setStroke()
                context.setLineWidth(hlineWidth)
                context.move(to: CGPoint(x: h, y: v + baseLine))
                context.addLine(to: CGPoint(x: rect.maxX, y: v + baseLine))
                context.strokePath()
                context.restoreGState()
            }

            // Ascender
            do {
                context.saveGState()
                GuideLabel.colorAscender.setStroke()
                context.setLineWidth(vlineWidth)
                context.move(to: CGPoint(x: h, y: v + ascenderTop))
                context.addLine(to: CGPoint(x: h, y: v + baseLine))
                context.strokePath()
                context.restoreGState()
            }
            
            // Dscender
            do {
                context.saveGState()
                GuideLabel.colorDescender.setStroke()
                context.setLineWidth(vlineWidth)
                context.move(to: CGPoint(x: h, y: v + baseLine))
                context.addLine(to: CGPoint(x: h, y: v + descenderBottom))
                context.strokePath()
                context.restoreGState()
            }
            
            h += vlineWidth
            
            // Cap height
            do {
                context.saveGState()
                GuideLabel.colorCapHeight.setStroke()
                context.setLineWidth(vlineWidth)
                context.move(to: CGPoint(x: h, y: v + capHeightTop))
                context.addLine(to: CGPoint(x: h, y: v + baseLine))
                context.strokePath()
                context.restoreGState()
            }
            do {
                context.saveGState()
                GuideLabel.colorCapHeight.setStroke()
                context.setLineDash(phase: 0, lengths: [2,2])
                context.move(to: CGPoint(x: h, y: v + capHeightTop))
                context.addLine(to: CGPoint(x: rect.maxX, y: v + capHeightTop))
                context.strokePath()
                context.restoreGState()
            }
            
            h += vlineWidth
            
            // X height
            do {
                context.saveGState()
                GuideLabel.colorXHeight.setStroke()
                context.setLineWidth(vlineWidth)
                context.move(to: CGPoint(x: h, y: v + xHeightTop))
                context.addLine(to: CGPoint(x: h, y: v + baseLine))
                context.strokePath()
                context.restoreGState()
            }
            do {
                context.saveGState()
                GuideLabel.colorXHeight.setStroke()
                context.setLineDash(phase: 0, lengths: [2,2])
                context.move(to: CGPoint(x: h, y: v + xHeightTop))
                context.addLine(to: CGPoint(x: rect.maxX, y: v + xHeightTop))
                context.strokePath()
                context.restoreGState()
            }

            
        }
        
    }
    
}
