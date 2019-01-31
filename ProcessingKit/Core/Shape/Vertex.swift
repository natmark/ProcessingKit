//
//  Vertex.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/09/27.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

public enum BeginShapeKind {
    case points
    case lines
    case triangles
    case quads
    case none
}

public enum EndShapeMode {
    case close
    case none
}

public protocol VertexComponentsContract {
    var vertexes: [CGPoint] { get set }
    var kind: BeginShapeKind { get set }
}

public protocol VertexModelContract {
    mutating func beginShape(_ kind: BeginShapeKind)
    mutating func endShape(_ mode: EndShapeMode)
    mutating func vertex(_ x: CGFloat, _ y: CGFloat)
}

public class VertexComponents: VertexComponentsContract {
    public var vertexes: [CGPoint] = []
    public var kind: BeginShapeKind = .none

    public init() {}
}

public struct VertexModel: VertexModelContract {
    private var contextComponents: ContextComponenetsContract
    private var vertexComponents: VertexComponentsContract
    private var colorComponents: ColorComponentsContract

    public init(contextComponents: ContextComponenetsContract, vertexComponents: VertexComponentsContract, colorComponents: ColorComponentsContract) {
        self.contextComponents = contextComponents
        self.vertexComponents = vertexComponents
        self.colorComponents = colorComponents
    }

    public mutating func beginShape(_ kind: BeginShapeKind) {
        self.vertexComponents.kind = kind
        self.vertexComponents.vertexes.removeAll()
    }

    public mutating func endShape(_ mode: EndShapeMode) {
        guard self.vertexComponents.vertexes.count > 0 else {
            return
        }

        switch self.vertexComponents.kind {
        case .points:
            let context = self.contextComponents.context
            context?.setFillColor(self.colorComponents.stroke.cgColor)
            for vertex in self.vertexComponents.vertexes {
                context?.fill(CGRect(x: vertex.x, y: vertex.y, width: self.colorComponents.strokeWeight, height: self.colorComponents.strokeWeight))
            }
        case .lines:
            while self.vertexComponents.vertexes.count >= 2 {
                let arrSlice: ArraySlice = self.vertexComponents.vertexes.prefix(2)
                let vertexes = arrSlice.map { $0 }
                addLineToPoints(vertexes: vertexes, isClosed: false)
                self.vertexComponents.vertexes.removeFirst(2)
            }
        case .triangles:
            while self.vertexComponents.vertexes.count >= 3 {
                let arrSlice: ArraySlice = self.vertexComponents.vertexes.prefix(3)
                let vertexes = arrSlice.map { $0 }
                addLineToPoints(vertexes: vertexes, isClosed: true)
                self.vertexComponents.vertexes.removeFirst(3)
            }
        case .quads:
            while self.vertexComponents.vertexes.count >= 4 {
                let arrSlice: ArraySlice = self.vertexComponents.vertexes.prefix(4)
                let vertexes = arrSlice.map { $0 }
                addLineToPoints(vertexes: vertexes, isClosed: true)
                self.vertexComponents.vertexes.removeFirst(4)
            }
        case .none:
            self.addLineToPoints(vertexes: self.vertexComponents.vertexes, isClosed: mode == .close)
        }

        self.vertexComponents.vertexes.removeAll()
    }

    public mutating func vertex(_ x: CGFloat, _ y: CGFloat) {
        self.vertexComponents.vertexes.append(CGPoint(x: x, y: y))
    }

    private func addLineToPoints(vertexes: [CGPoint], isClosed: Bool) {
        let context = self.contextComponents.context
        setGraphicsConfiguration(context: context)

        for (index, vertex) in vertexes.enumerated() {
            if index == 0 {
                context?.move(to: vertex)
            } else {
                context?.addLine(to: vertex)
            }
        }
        if isClosed {
            context?.addLine(to: vertexes.first!)
        }
        context?.drawPath(using: .fillStroke)
    }

    private func setGraphicsConfiguration(context: CGContext?) {
        context?.setFillColor(self.colorComponents.fill.cgColor)
        context?.setStrokeColor(self.colorComponents.stroke.cgColor)
        context?.setLineWidth(self.colorComponents.strokeWeight)
    }
}
