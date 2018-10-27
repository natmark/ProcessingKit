//
//  CGPathElement+Extension.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2018/10/08.
//  Copyright © 2018 Atsuya Sato. All rights reserved.
//

import UIKit

extension CGPathElement: Equatable {}

public func == (lhs: CGPathElement, rhs: CGPathElement) -> Bool {
    if lhs.type != rhs.type {
        return false
    }

    switch (lhs.type) {
    case CGPathElementType.moveToPoint:
        return lhs.points[0] == rhs.points[0]
    case .addLineToPoint:
        return lhs.points[0] == rhs.points[0]
    case .addQuadCurveToPoint:
        return lhs.points[0] == rhs.points[0] && lhs.points[1] == rhs.points[1]
    case .addCurveToPoint:
        return lhs.points[0] == rhs.points[0] && lhs.points[1] == rhs.points[1] && lhs.points[2] == rhs.points[2]
    case .closeSubpath:
        return true
    }
}
