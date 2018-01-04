//
//  Image.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

#if !os(iOS)
import Cocoa
#endif

public protocol ImageModelContract {
    #if os(iOS)
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat)
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    #else
    func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat)
    func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    #endif
}

struct ImageModel: ImageModelContract {
    #if os(iOS)
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat) {
        let g = MultiplatformCommon.getCurrentContext()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: img.size.height)
        g?.scaleBy(x: 1.0, y: -1.0)
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: y, width: img.size.width, height: img.size.height))
        }
        g?.restoreGState()
    }

    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = MultiplatformCommon.getCurrentContext()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: height)
        g?.scaleBy(x: 1.0, y: -1.0)
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: -y, width: width, height: height))
        }
        g?.restoreGState()
    }
    #else
    func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat) {
        let g = MultiplatformCommon.getCurrentContext()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: img.size.height)
        g?.scaleBy(x: 1.0, y: -1.0)
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: y, width: img.size.width, height: img.size.height))
        }
        g?.restoreGState()
    }

    func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = MultiplatformCommon.getCurrentContext()
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

// MARK: - ProcessingView Public APIs
extension ProcessingView: ImageModelContract {
    #if os(iOS)
    public func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat) {
        self.imageModel.image(img, x, y)
    }

    public func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.imageModel.image(img, x, y, width, height)
    }
    #else
    public func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat) {
        self.imageModel.drawImage(img, x, y)
    }

    public func drawImage(_ img: NSImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.imageModel.drawImage(img, x, y, width, height)
    }
    #endif
}
