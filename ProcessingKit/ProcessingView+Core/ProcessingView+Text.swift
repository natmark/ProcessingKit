//
//  ProcessingView+Text.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2018/09/09.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

extension ProcessingView: TextModelContract {
    public func text(_ str: String, _ x: CGFloat, _ y: CGFloat) {
        self.textModel.text(str, x, y)
    }

    public func text(_ str: String, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.textModel.text(str, x, y, width, height)
    }

    public func textWidth(_ str: String) -> CGFloat {
        return self.textModel.textWidth(str)
    }

    public func textSize(_ size: CGFloat) {
        self.textModel.textSize(size)
    }

    public func textFont(_ font: UIFont) {
        self.textModel.textFont(font)
    }

    public func textAlign(_ allignX: NSTextAlignment) {
        self.textModel.textAlign(allignX)
    }
}
