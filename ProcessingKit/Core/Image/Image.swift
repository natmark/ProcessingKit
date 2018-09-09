//
//  Image.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

public protocol ImageModelContract {
    #if os(iOS)
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat)
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    #elseif os(OSX)
    func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat)
    func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    #endif
}

public struct ImageModel: ImageModelContract {
    private var contextComponents: ContextComponenetsContract

    public init(contextComponents: ContextComponenetsContract) {
        self.contextComponents = contextComponents
    }

    #if os(iOS)
    public func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat) {
        let g = self.contextComponents.context()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: img.size.height)
        g?.scaleBy(x: 1.0, y: -1.0)
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: y, width: img.size.width, height: img.size.height))
        }
        g?.restoreGState()
    }

    public func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = self.contextComponents.context()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: height)
        g?.scaleBy(x: 1.0, y: -1.0)
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: -y, width: width, height: height))
        }
        g?.restoreGState()
    }
    #elseif os(OSX)
    public func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat) {
        let g = self.contextComponents.context()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: img.size.height)
        g?.scaleBy(x: 1.0, y: -1.0)
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: y, width: img.size.width, height: img.size.height))
        }
        g?.restoreGState()
    }

    public func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = self.contextComponents.context()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: height)
        g?.scaleBy(x: 1.0, y: -1.0)
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: -y, width: width, height: height))
        }
        g?.restoreGState()
    }
    #endif
}
