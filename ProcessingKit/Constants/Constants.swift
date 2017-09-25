//
//  Constants.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

public protocol Constants {
    var HALF_PI: CGFloat { get }
    var PI: CGFloat { get }
    var QUARTER_PI: CGFloat { get }
    var TAU: CGFloat { get }
    var TWO_PI: CGFloat { get }
}

extension ProcessingView: Constants {
    public var HALF_PI: CGFloat {
        return .pi / 2
    }

    public var PI: CGFloat {
        return .pi
    }

    public var QUARTER_PI: CGFloat {
        return .pi / 4
    }

    public var TAU: CGFloat {
        return self.TWO_PI
    }

    public var TWO_PI: CGFloat {
        return .pi * 2
    }
}
