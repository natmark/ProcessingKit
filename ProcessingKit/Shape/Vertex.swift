//
//  Vertex.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/09/27.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

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

class VertexComponents {
    var vertexes: [CGPoint] = []
    var kind: BeginShapeKind = .none
}

protocol VertexModelContract {
    func beginShape(_ kind: BeginShapeKind)
    func endShape(_ mode: EndShapeMode)
    func vertex(_ x: CGFloat, _ y: CGFloat)
}

struct VertexModel: VertexModelContract {
    private var vertexComponents: VertexComponents
    private var colorComponents: ColorComponents

    init(vertexComponents: VertexComponents, colorComponents: ColorComponents) {
        self.vertexComponents = vertexComponents
        self.colorComponents = colorComponents
    }

    func beginShape(_ kind: BeginShapeKind) {
        self.vertexComponents.kind = kind
        self.vertexComponents.vertexes.removeAll()
    }

    func endShape(_ mode: EndShapeMode) {
        guard self.vertexComponents.vertexes.count > 0 else {
            return
        }

        switch self.vertexComponents.kind {
        case .points:
            let g = UIGraphicsGetCurrentContext()
            g?.setFillColor(self.colorComponents.stroke.cgColor)
            for vertex in self.vertexComponents.vertexes {
                g?.fill(CGRect(x: vertex.x, y: vertex.y, width: 1.0, height: 1.0))
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

    func vertex(_ x: CGFloat, _ y: CGFloat) {
        self.vertexComponents.vertexes.append(CGPoint(x: x, y: y))
    }

    private func addLineToPoints(vertexes: [CGPoint], isClosed: Bool) {
        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)

        for (index, vertex) in vertexes.enumerated() {
            if index == 0 {
                g?.move(to: vertex)
            } else {
                g?.addLine(to: vertex)
            }
        }
        if isClosed {
            g?.addLine(to: vertexes.first!)
        }
        g?.strokePath()
        g?.fillPath()
        g?.closePath()
    }

    private func setGraphicsConfiguration(context: CGContext?) {
        context?.setFillColor(self.colorComponents.fill.cgColor)
        context?.setStrokeColor(self.colorComponents.stroke.cgColor)
        context?.setLineWidth(self.colorComponents.strokeWeight)
    }
}

extension ProcessingView: VertexModelContract {
    public func beginShape(_ kind: BeginShapeKind = .none) {
        self.vertexModel.beginShape(kind)
    }

    public func endShape(_ mode: EndShapeMode = .none) {
        self.vertexModel.endShape(mode)
    }

    public func vertex(_ x: CGFloat, _ y: CGFloat) {
        self.vertexModel.vertex(x, y)
    }
}
