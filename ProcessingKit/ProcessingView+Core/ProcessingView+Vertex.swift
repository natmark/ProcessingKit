//
//  ProcessingView+Vertex.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2018/09/09.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
import ProcessingKitCore
#elseif os(OSX)
import Cocoa
import ProcessingKitCoreOSX
#endif

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
