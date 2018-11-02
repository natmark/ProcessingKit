//
//  CGPath+Extension.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2018/10/08.
//  Copyright © 2018 Atsuya Sato. All rights reserved.
//

import UIKit

extension CGPath {
    func forEach( body: @escaping @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        //print(MemoryLayout.size(ofValue: body))
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }

    var elements: [CGPathElement] {
        var elements = [CGPathElement]()
        self.forEach { element in
            elements.append(element)
        }
        return elements
    }
}
extension CGPath: Equatable {}

public func == (lhs: CGPath, rhs: CGPath) -> Bool {
    return lhs.elements == rhs.elements
}
