//
//  Text.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

public protocol TextComponentsContract {
    var textSize: CGFloat { get set }
    var textFont: UIFont { get set }
    var textAlignX: NSTextAlignment { get set }
}

public protocol TextModelContract {
    func text(_ str: String, _ x: CGFloat, _ y: CGFloat)
    func text(_ str: String, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    func textWidth(_ str: String) -> CGFloat
    mutating func textSize(_ size: CGFloat)
    mutating func textFont(_ font: UIFont)
    mutating func textAlign(_ allignX: NSTextAlignment)
}

public class TextComponents: TextComponentsContract {
    public var textSize: CGFloat = 20.0
    public var textFont: UIFont = UIFont.systemFont(ofSize: 20.0)
    public var textAlignX: NSTextAlignment = .left

    public init() {}
}

public struct TextModel: TextModelContract {
    private var contextComponents: ContextComponenetsContract
    private var textComponents: TextComponentsContract
    private var colorComponents: ColorComponentsContract
    private var frameComponents: FrameComponentsContract

    public init(contextComponents: ContextComponenetsContract, frameComponents: FrameComponentsContract, textComponents: TextComponentsContract, colorComponents: ColorComponentsContract) {
        self.contextComponents = contextComponents
        self.frameComponents = frameComponents
        self.textComponents = textComponents
        self.colorComponents = colorComponents
    }

    public func text(_ str: String, _ x: CGFloat, _ y: CGFloat) {
        let width = self.textWidth(str)
        let height = str.height(withConstrainedWidth: width, font: self.textComponents.textFont)
        if self.textComponents.textAlignX == .center {
            self.text(str, x - width / 2, y, width, height)
            return
        }
        self.text(str, x, y, width, height)
    }

    public func text(_ str: String, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = self.contextComponents.context()

        g?.saveGState()

        g?.translateBy(x: 0, y: frameComponents.bounds.size.height)
        g?.scaleBy(x: 1.0, y: -1.0)
        g?.textMatrix = CGAffineTransform.identity

        let path: CGMutablePath = CGMutablePath()
        let bounds: CGRect = CGRect(x: x, y: -y + frameComponents.bounds.size.height, width: width, height: height)
        path.addRect(bounds)

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = self.textComponents.textAlignX

        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.paragraphStyle: paragraph]

        let attrString = NSMutableAttributedString(string: str, attributes: attributes)

        // set font
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, attrString.length), kCTFontAttributeName, self.textComponents.textFont)

        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, attrString.length), kCTForegroundColorAttributeName, self.colorComponents.fill.cgColor)

        let framesetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attrString)

        let frame: CTFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)

        // 上記の内容を描画します。
        CTFrameDraw(frame, g!)

        g?.restoreGState()
    }

    public func textWidth(_ str: String) -> CGFloat {
        let size = str.size(withAttributes: [NSAttributedStringKey.font: self.textComponents.textFont])
        return size.width
    }

    public mutating func textSize(_ size: CGFloat) {
        self.textComponents.textSize = size
        self.textComponents.textFont = UIFont.systemFont(ofSize: size)
    }

    public mutating func textFont(_ font: UIFont) {
        self.textComponents.textFont = font
        self.textComponents.textSize = font.pointSize
    }

    public mutating func textAlign(_ allignX: NSTextAlignment) {
        self.textComponents.textAlignX = allignX
    }
}
