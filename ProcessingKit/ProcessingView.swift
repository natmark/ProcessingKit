//
//  ProcessingView.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

open class ProcessingView: UIImageView {
    public weak var delegate: ProcessingViewDelegate?
    public weak var gesture: ProcessingViewGestureDelegate?

    public var autoRelease = true
    public var isPlayground = false

    // MARK: Internal properties
    lazy var frameModel: FrameModelContract = {
        return FrameModel(
            frameComponents: self.frameComponents,
            timer: self.timer
        )
    }()
    lazy var shapeModel: ShapeModelContract = {
        return ShapeModel(
            contextComponents: self.contextComponents,
            colorComponents: self.colorComponents
        )
    }()
    lazy var vertexModel: VertexModelContract = {
        return VertexModel(
            contextComponents: self.contextComponents,
            vertexComponents: self.vertexComponents,
            colorComponents: self.colorComponents
        )
    }()
    lazy var gestureModel: GestureModelContract = {
        return GestureModel(
            gestureComponents: self.gestureComponents,
            frameComponents: self.frameComponents
        )
    }()
    lazy var dateModel: DateModelContract = {
        return DateModel(startDate: Date())
    }()
    lazy var colorModel: ColorModelContract = {
        return ColorModel(
            contextComponents: self.contextComponents,
            colorComponents: self.colorComponents,
            frameComponents: self.frameComponents
        )
    }()
    lazy var textModel: TextModelContract = {
        return TextModel(
            contextComponents: self.contextComponents,
            frameComponents: self.frameComponents,
            textComponents: self.textComponents,
            colorComponents: self.colorComponents
        )
    }()
    lazy var imageModel: ImageModelContract = {
        return ImageModel(contextComponents: self.contextComponents)
    }()
    lazy var transformModel: TransformModelContract = {
        return TransformModel(contextComponents: self.contextComponents)
    }()

    var timer: Timer?

    // MARK: Gesture Recognizers
    #if os(iOS)
    lazy var tapGestureWithSingleTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    lazy var tapGestureWithDoubleTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 2
        return recognizer
    }()
    lazy var tapGestureWithTripleTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 3
        return recognizer
    }()
    lazy var tapGestureWithQuadTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 4
        return recognizer
    }()
    lazy var tapGestureWithQuintTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 5
        return recognizer
    }()
    lazy var swipeUpGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(recognizer:)))
        recognizer.direction = .up
        return recognizer
    }()
    lazy var swipeDownGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(recognizer:)))
        recognizer.direction = .down
        return recognizer
    }()
    lazy var swipeLeftGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(recognizer:)))
        recognizer.direction = .left
        return recognizer
    }()
    lazy var swipeRightGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(recognizer:)))
        recognizer.direction = .right
        return recognizer
    }()
    lazy var pinchGesture: UIPinchGestureRecognizer = {
        let pinch =  UIPinchGestureRecognizer(target: self, action: #selector(didPinch(recognizer:)))
        return pinch
    }()
    lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(didPan(recognizer:)))
    }()
    lazy var rotationGesture: UIRotationGestureRecognizer = {
        let rotate =  UIRotationGestureRecognizer(target: self, action: #selector(didRotate(recognizer:)))
        return rotate
    }()
    lazy var longPressGesture: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(recognizer:)))
    }()
    #elseif os(OSX)
    lazy var clickGesture: NSClickGestureRecognizer = {
        return NSClickGestureRecognizer(target: self, action: #selector(didClick(recognizer:)))
    }()
    lazy var magnificationGesture: NSMagnificationGestureRecognizer = {
        return NSMagnificationGestureRecognizer(target: self, action: #selector(didMagnify(recognizer:)))
    }()
    lazy var panGesture: NSPanGestureRecognizer = {
        return NSPanGestureRecognizer(target: self, action: #selector(didPan(recognizer:)))
    }()
    lazy var pressGesture: NSPressGestureRecognizer = {
        return NSPressGestureRecognizer(target: self, action: #selector(didPress(recognizer:)))
    }()
    lazy var rotationGesture: NSRotationGestureRecognizer = {
        return NSRotationGestureRecognizer(target: self, action: #selector(didRotate(recognizer:)))
    }()
    #endif

    // MARK: Private properties
    private var contextComponents = ContextComponents()
    private var colorComponents = ColorComponents()
    private var gestureComponents = GestureComponents()
    private var vertexComponents = VertexComponents()
    private var textComponents = TextComponents()
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
        self.addGestureRecognizers()
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
        self.delegate = self
        self.gesture = self
    }

    func addGestureRecognizers() {
        #if os(iOS)
        tapGestureWithSingleTouch.delegate = self
        tapGestureWithDoubleTouch.delegate = self
        tapGestureWithTripleTouch.delegate = self
        tapGestureWithQuadTouch.delegate = self
        tapGestureWithQuintTouch.delegate = self
        panGesture.delegate = self
        swipeUpGesture.delegate = self
        swipeDownGesture.delegate = self
        swipeLeftGesture.delegate = self
        swipeRightGesture.delegate = self
        pinchGesture.delegate = self
        rotationGesture.delegate = self
        longPressGesture.delegate = self

        self.addGestureRecognizer(tapGestureWithSingleTouch)
        self.addGestureRecognizer(tapGestureWithDoubleTouch)
        self.addGestureRecognizer(tapGestureWithTripleTouch)
        self.addGestureRecognizer(tapGestureWithQuadTouch)
        self.addGestureRecognizer(tapGestureWithQuintTouch)
        self.addGestureRecognizer(panGesture)
        self.addGestureRecognizer(swipeUpGesture)
        self.addGestureRecognizer(swipeDownGesture)
        self.addGestureRecognizer(swipeLeftGesture)
        self.addGestureRecognizer(swipeRightGesture)
        self.addGestureRecognizer(pinchGesture)
        self.addGestureRecognizer(rotationGesture)
        self.addGestureRecognizer(longPressGesture)
        #elseif os(OSX)
        self.addGestureRecognizer(clickGesture)
        self.addGestureRecognizer(magnificationGesture)
        self.addGestureRecognizer(panGesture)
        self.addGestureRecognizer(pressGesture)
        self.addGestureRecognizer(rotationGesture)
        #endif
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
        #if os(iOS)
        UIGraphicsBeginImageContext(rect.size)
        self.image?.draw(at: CGPoint.zero)
        #elseif os(OSX)
        self.image?.draw(at: NSPoint.zero, from: NSRect.zero, operation: .copy, fraction: 1.0)

        // MARK: Coordinate systems are different between iOS and OS X
        let context = contextComponents.context
        context?.saveGState()
        context?.translateBy(x: 0.0, y: height)
        context?.scaleBy(x: 1.0, y: -1.0)
        #endif

        // Setup
        if firstcall {
            self.firstcall = false
            self.delegate?.setup?()
        }

        // Gesture events
        self.callDelegatesIfNeeded()

        // Draw
        self.frameComponents.frameCount += 1
        self.delegate?.draw?()

        #if os(iOS)
        let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
        self.image = drawnImage
        UIGraphicsEndImageContext()
        #elseif os(OSX)
            if let cgImage = NSGraphicsContext.current?.cgContext.makeImage() {
            DispatchQueue.main.async {
                self.image = NSImage(cgImage: cgImage, size: self.frame.size)
                self.setNeedsDisplay()
            }
        }
        context?.restoreGState()
        #endif

        // Only setup
        if self.delegate?.draw == nil {
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

    private func callDelegatesIfNeeded() {
        for event in self.gestureComponents.delegateEvents {
            sendDelegate(event: event)
        }

        self.gestureComponents.delegateEvents.removeAll()
    }

    #if os(iOS)
    private func sendDelegate(event: GestureEvent) {
        switch event {
        case .didTap:
            self.gesture?.didTap?()
        case .didRelease:
            self.gesture?.didRelease?()
        case .didDrag:
            self.gesture?.didDrag?()
        case .didSwipe(let direction):
            self.gesture?.didSwipe?(direction: direction)
        case .didPinch(let scale, let velocity):
            self.gesture?.didPinch?(scale: scale, velocity: velocity)
        case .didRotate(let rotation, let velocity):
            self.gesture?.didRotate?(rotation: rotation, velocity: velocity)
        case .didLongPress:
            self.gesture?.didLongPress?()
        }
    }
    #elseif os(OSX)
    private func sendDelegate(event: GestureEvent) {
        switch event {
        case .didClick:
            self.gesture?.didClick?()
        case .didRelease:
            self.gesture?.didRelease?()
        case .didDrag:
            self.gesture?.didDrag?()
        case .didMove:
            self.gesture?.didMove?()
        case .didMagnify(let magnification):
            self.gesture?.didMagnify?(magnification: magnification)
        case .didRotate(let rotation, let inDegrees):
            self.gesture?.didRotate?(rotation: rotation, inDegrees: inDegrees)
        case .didPress:
            self.gesture?.didPress?()
        case .didScroll(let x, let y):
            self.gesture?.didScroll?(x: x, y: y)
        }
    }
    #endif

    // MARK: - deinit
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
}

extension ProcessingView: ProcessingViewGestureDelegate {}
extension ProcessingView: ProcessingViewDelegate {}

#if os(iOS)
extension ProcessingView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
#endif

#if os(OSX)
extension ProcessingView {
    override open func updateTrackingAreas() {
        if trackingArea != nil {
            self.removeTrackingArea(trackingArea!)
        }
        let options: NSTrackingArea.Options =
            [.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow]
        trackingArea = NSTrackingArea(rect: self.bounds, options: options,
                                      owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea!)
    }
}
#endif
