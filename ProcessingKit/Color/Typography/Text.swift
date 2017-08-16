//
//  Text.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

struct TextComponents {
    var textSize_: CGFloat = 20.0
    var textFont_: UIFont = UIFont.systemFont(ofSize: 20.0)
    var textAlignX_: NSTextAlignment = .left
}

public protocol Text {
    func text(_ str: String, _ x: CGFloat, _ y: CGFloat)
    func text(_ str: String, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    func textSize(_ size: CGFloat)
    func textFont(_ font: UIFont)
    func textAlign(_ allignX: NSTextAlignment)
    func textWidth(_ str: String) -> CGFloat
}

extension ProcessingView: Text {
    public func textAlign(_ allignX: NSTextAlignment) {
        textComponents.textAlignX_ = allignX
    }

    public func textFont(_ font: UIFont) {
        textComponents.textFont_ = font
        textComponents.textSize_ = font.pointSize
    }

    public func textSize(_ size: CGFloat) {
        textComponents.textSize_ = size
        textComponents.textFont_ = UIFont(name: textComponents.textFont_.fontName, size: size) ?? UIFont.systemFont(ofSize: 20.0)
    }

    public func text(_ str: String, _ x: CGFloat, _ y: CGFloat) {
        let width = textWidth(str)
        let height = str.height(withConstrainedWidth: width, font: textComponents.textFont_)
        if textComponents.textAlignX_ == .center {
            self.text(str, x - width / 2, y, width, height)
            return
        }
        self.text(str, x, y, width, height)
    }

    public func text(_ str: String, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = UIGraphicsGetCurrentContext()

        g?.saveGState()

        g?.translateBy(x: 0, y: self.frame.size.height)
        g?.scaleBy(x: 1.0, y: -1.0)
        g?.textMatrix = CGAffineTransform.identity

        let path: CGMutablePath = CGMutablePath()
        let bounds: CGRect = CGRect(x: x, y: -y + self.frame.size.height, width: width, height: height)
        path.addRect(bounds)

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = textComponents.textAlignX_

        let attributes: [String : Any] = [NSParagraphStyleAttributeName: paragraph]

        let attrString = NSMutableAttributedString(string: str, attributes: attributes)

        // set font
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, attrString.length), kCTFontAttributeName, textComponents.textFont_)

        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, attrString.length), kCTForegroundColorAttributeName, colorComponents.fill_.cgColor)

        let framesetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attrString)

        let frame: CTFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)

        // 上記の内容を描画します。
        CTFrameDraw(frame, g!)

        g?.restoreGState()
    }
    public func textWidth(_ str: String) -> CGFloat {
        let size = str.size(attributes: [NSFontAttributeName : textComponents.textFont_])
        return size.width
    }
}
