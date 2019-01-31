//
//  CGPath+Extension.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2019/01/31.
//  Copyright © 2019 Atsuya Sato. All rights reserved.
//
import CoreGraphics

extension CGPath: Equatable {
    public static func ==(lhs: CGPath, rhs: CGPath) -> Bool {
        if lhs.getPathElementsPoints().count != rhs.getPathElementsPoints().count {
            return false
        }
        if lhs.firstPoint != rhs.firstPoint {
            return false
        }
        if lhs.currentPoint != rhs.currentPoint {
            return false
        }

        for i in 0..<lhs.getPathElementsPoints().count {
            let lhsElm = lhs.getPathElementsPointsAndTypes().0[i]
            let lhsElmType = lhs.getPathElementsPointsAndTypes().1[i]
            let rhsElm = rhs.getPathElementsPointsAndTypes().0[i]
            let rhsElmType = rhs.getPathElementsPointsAndTypes().1[i]

            if lhsElmType != rhsElmType {
                return false
            }
            if Int(lhsElm.x * 100000000000) != Int(rhsElm.x * 100000000000) {
                return false
            }
            if Int(lhsElm.y * 100000000000) != Int(rhsElm.y * 100000000000) {
                return false
            }
        }
        return true
    }
}

extension CGPath {
    var firstPoint: CGPoint? {
        var firstPoint: CGPoint? = nil

        self.forEach { element in
            // Just want the first one, but we have to look at everything
            guard firstPoint == nil else { return }
            assert(element.type == .moveToPoint, "Expected the first point to be a move")
            firstPoint = element.points.pointee
        }
        return firstPoint
    }

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
    func getPathElementsPoints() -> [CGPoint] {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
            default: break
            }
        }
        return arrayPoints
    }
    func getPathElementsPointsAndTypes() -> ([CGPoint],[CGPathElementType]) {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        var arrayTypes : [CGPathElementType]! = [CGPathElementType]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            default: break
            }
        }
        return (arrayPoints,arrayTypes)
    }
}
