//
//  Image.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

public protocol ImageModelContract {
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat)
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
}

struct ImageModel: ImageModelContract {
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: y, width: img.size.width, height: img.size.height))
        }
    }

    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: y, width: width, height: height))
        }
    }
}

// MARK: - ProcessingView Public APIs
extension ProcessingView: ImageModelContract {
    public func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat) {
        self.imageModel.image(img, x, y)
    }

    public func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.imageModel.image(img, x, y, width, height)
    }
}
