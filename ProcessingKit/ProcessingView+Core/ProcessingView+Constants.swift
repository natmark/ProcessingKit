//
//  ProcessingView+Constants.swift
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
