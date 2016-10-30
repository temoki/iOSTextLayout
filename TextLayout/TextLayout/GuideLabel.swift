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
    static let colorAscender = UIColor.orange
    static let colorDescender = UIColor.blue
    static let colorCapHeight = UIColor.green
    static let colorXHeight = UIColor.purple
    
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
        let lineHeight = font.lineHeight
        let ascenderY = font.ascender
        let descenderY = lineHeight + font.descender
        let baseLine = ascenderY
        let capHeightY = baseLine - font.capHeight
        let xHeightY = baseLine - font.xHeight
        
        let hlineWidth: CGFloat = 0.5
        let vlineWidth: CGFloat = 2
        
        let lineCount = Int((rect.size.height / lineHeight) * 1.1)
        for i in 0 ..< lineCount {
            let v = lineHeight * CGFloat(i)
            var h = rect.minX
            
            // Line height
            do {
                context.saveGState()
                GuideLabel.colorLineHeight.setStroke()
                context.setLineWidth(hlineWidth)
                context.move(to: CGPoint(x: h, y: v))
                context.addLine(to: CGPoint(x: rect.maxX, y: v))
                context.strokePath()
                context.restoreGState()
            }
            
            h += vlineWidth / 2

            // Ascender
            do {
                context.saveGState()
                GuideLabel.colorAscender.setStroke()
                context.setLineWidth(vlineWidth)
                context.move(to: CGPoint(x: h, y: v))
                context.addLine(to: CGPoint(x: h, y: v + ascenderY))
                context.strokePath()
                context.restoreGState()
            }
            do {
                context.saveGState()
                GuideLabel.colorAscender.setStroke()
                context.setLineWidth(hlineWidth)
                context.setLineDash(phase: 0, lengths: [3,3])
                context.move(to: CGPoint(x: h, y: v + ascenderY))
                context.addLine(to: CGPoint(x: rect.maxX, y: v + ascenderY))
                context.strokePath()
                context.restoreGState()
            }
            
            // Dscender
            do {
                context.saveGState()
                GuideLabel.colorDescender.setStroke()
                context.setLineWidth(vlineWidth)
                context.move(to: CGPoint(x: h, y: v + descenderY))
                context.addLine(to: CGPoint(x: h, y: v + lineHeight))
                context.strokePath()
                context.restoreGState()
            }
            do {
                context.saveGState()
                GuideLabel.colorDescender.setStroke()
                context.setLineWidth(hlineWidth)
                context.setLineDash(phase: 3, lengths: [3,3])
                context.move(to: CGPoint(x: h, y: v + descenderY))
                context.addLine(to: CGPoint(x: rect.maxX, y: v + descenderY))
                context.strokePath()
                context.restoreGState()
            }
            
            h += vlineWidth
            
            // Cap height
            do {
                context.saveGState()
                GuideLabel.colorCapHeight.setStroke()
                context.setLineWidth(vlineWidth)
                context.move(to: CGPoint(x: h, y: v + capHeightY))
                context.addLine(to: CGPoint(x: h, y: v + baseLine))
                context.strokePath()
                context.restoreGState()
            }
            do {
                context.saveGState()
                GuideLabel.colorCapHeight.setStroke()
                context.setLineDash(phase: 0, lengths: [2,2])
                context.move(to: CGPoint(x: h, y: v + capHeightY))
                context.addLine(to: CGPoint(x: rect.maxX, y: v + capHeightY))
                context.strokePath()
                context.restoreGState()
            }
            
            h += vlineWidth
            
            // X height
            do {
                context.saveGState()
                GuideLabel.colorXHeight.setStroke()
                context.setLineWidth(vlineWidth)
                context.move(to: CGPoint(x: h, y: v + xHeightY))
                context.addLine(to: CGPoint(x: h, y: v + baseLine))
                context.strokePath()
                context.restoreGState()
            }
            do {
                context.saveGState()
                GuideLabel.colorXHeight.setStroke()
                context.setLineDash(phase: 0, lengths: [2,2])
                context.move(to: CGPoint(x: h, y: v + xHeightY))
                context.addLine(to: CGPoint(x: rect.maxX, y: v + xHeightY))
                context.strokePath()
                context.restoreGState()
            }

            
        }
        
        // Line separator
        do {
            let bottomY = lineHeight * CGFloat(lineCount)
            context.saveGState()
            GuideLabel.colorLineHeight.setStroke()
            context.setLineWidth(hlineWidth)
            context.move(to: CGPoint(x: rect.minX, y: bottomY))
            context.addLine(to: CGPoint(x: rect.maxX, y: bottomY))
            context.strokePath()
            context.restoreGState()
        }

    }
    
}
