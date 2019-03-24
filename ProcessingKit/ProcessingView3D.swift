//
//  ProcessingView3D.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2019/03/24.
//  Copyright © 2019 Atsuya Sato. All rights reserved.
//

import Foundation
import SpriteKit

open class ProcessingView3D: SKView {
    public weak var processingViewDelegate: ProcessingViewDelegate?

    public var autoRelease = true
    public var isPlayground = false

    // MARK: Internal properties
    lazy var frameModel: FrameModelContract = {
        return FrameModel(
            frameComponents: self.frameComponents,
            timer: self.timer
        )
    }()

    var timer: Timer?

    // MARK: Private properties
    private var frameComponents = FrameComponents()

    // Flag for setup function (setup function execute only once)
    private var firstcall = true

    // Store trackingArea for calling mouseMove
    #if os(OSX)
    private var trackingArea: NSTrackingArea?
    #endif

    // MARK: - Initializer
    public init() {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    private func commonInit() {
        self.configuration()
        self.run()
    }

    private func configuration() {
        #if os(iOS)
        self.isUserInteractionEnabled = true
        #elseif os(OSX)
        if let window = self.window {
            self.bounds = CGRect(x: 0, y: 0, width: window.frame.size.width, height: window.frame.size.height)
        } else {
            self.bounds = CGRect.zero
        }
        #endif
        self.processingViewDelegate = self
    }

    private func run() {
        self.frameRate(60.0)
    }

    private func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while true {
            #if os(iOS)
            guard let nextResponder = parentResponder?.next else { return nil }
            #else
            guard let nextResponder = parentResponder?.nextResponder else { return nil }
            #endif
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
    }

    // MARK: - Notifications
    @objc private func suspend(notification: NSNotification) {
        self.noLoop()
    }

    @objc private func resume(notification: NSNotification) {
        self.loop()
    }

    // MARK: - Override Methods
    open override func draw(_ rect: CGRect) {
//        #if os(iOS)
//        UIGraphicsBeginImageContext(rect.size)
//        self.image?.draw(at: CGPoint.zero)
//        #elseif os(OSX)
//        self.image?.draw(at: NSPoint.zero, from: NSRect.zero, operation: .copy, fraction: 1.0)
//
//        // MARK: Coordinate systems are different between iOS and OS X
//        let context = contextComponents.context
//        context?.saveGState()
//        context?.translateBy(x: 0.0, y: height)
//        context?.scaleBy(x: 1.0, y: -1.0)
//        #endif

        // Setup
        if firstcall {
            self.firstcall = false
            self.processingViewDelegate?.setup?()
        }

        // Draw
        self.frameComponents.frameCount += 1
        self.processingViewDelegate?.draw?()

//        #if os(iOS)
//        let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
//        self.image = drawnImage
//        UIGraphicsEndImageContext()
//        #elseif os(OSX)
//        if let cgImage = NSGraphicsContext.current?.cgContext.makeImage() {
//            DispatchQueue.main.async {
//                self.image = NSImage(cgImage: cgImage, size: self.frame.size)
//                self.setNeedsDisplay()
//            }
//        }
//        context?.restoreGState()
//        #endif

        // Only setup
        if self.processingViewDelegate?.draw == nil {
            self.noLoop()
            return
        }

        // Deallocate timer
        if self.parentViewController() == nil {
            if autoRelease == true && isPlayground == false {
                self.noLoop()
            }
        }
    }

    // MARK: - Update view bounds
    open override var frame: CGRect {
        didSet {
            frameComponents.frame = self.frame
            frameComponents.bounds = self.bounds
        }
    }
    open override var bounds: CGRect {
        didSet {
            if frameComponents.frame == CGRect.zero {
                frameComponents.frame = self.frame
                frameComponents.bounds = self.bounds
            }
        }
    }

    // MARK: - deinit
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
}

extension ProcessingView3D: ProcessingViewDelegate {}
