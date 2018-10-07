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

@objc public protocol ProcessingViewDelegate {
    @objc optional func setup()
    @objc optional func draw()
}

@objc public protocol ProcessingViewGestureDelegate {
    #if os(iOS)
    @objc optional func didTap()
    @objc optional func didRelease()
    @objc optional func didDrag() //Pan
    @objc optional func didSwipe(direction: UISwipeGestureRecognizer.Direction)
    @objc optional func didPinch(scale: CGFloat, velocity: CGFloat)
    @objc optional func didRotate(rotation: CGFloat, velocity: CGFloat)
    @objc optional func didLongPress()
    #elseif os(OSX)
    @objc optional func didClick()
    @objc optional func didRelease()
    @objc optional func didDrag()
    @objc optional func didMove()
    @objc optional func didMagnify(magnification: CGFloat)
    @objc optional func didRotate(rotation: CGFloat, inDegrees: CGFloat)
    @objc optional func didPress()
    @objc optional func didScroll(x: CGFloat, y: CGFloat)
    #endif
}

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
            processingView: self
        )
    }()
    lazy var dateModel: DateModelContract = {
        return DateModel()
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

    // MARK: Private properties
    private var contextComponents = ContextComponents()
    private var colorComponents = ColorComponents()
    private var gestureComponents = GestureComponents()
    private var vertexComponents = VertexComponents()
    private var textComponents = TextComponents()
    private var frameComponents = FrameComponents()

    // MARK: Gesture Recognizers
    #if os(iOS)
    private lazy var tapGestureWithSingleTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    private lazy var tapGestureWithDoubleTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 2
        return recognizer
    }()
    private lazy var tapGestureWithTripleTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 3
        return recognizer
    }()
    private lazy var tapGestureWithQuadTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 4
        return recognizer
    }()
    private lazy var tapGestureWithQuintTouch: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        recognizer.numberOfTouchesRequired = 5
        return recognizer
    }()
    private lazy var swipeUpGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(recognizer:)))
        recognizer.direction = .up
        return recognizer
    }()
    private lazy var swipeDownGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(recognizer:)))
        recognizer.direction = .down
        return recognizer
    }()
    private lazy var swipeLeftGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(recognizer:)))
        recognizer.direction = .left
        return recognizer
    }()
    private lazy var swipeRightGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(recognizer:)))
        recognizer.direction = .right
        return recognizer
    }()
    private lazy var pinchGesture: UIPinchGestureRecognizer = {
        let pinch =  UIPinchGestureRecognizer(target: self, action: #selector(didPinch(recognizer:)))
        return pinch
    }()
    private lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(didPan(recognizer:)))
    }()
    private lazy var rotationGesture: UIRotationGestureRecognizer = {
        let rotate =  UIRotationGestureRecognizer(target: self, action: #selector(didRotate(recognizer:)))
        return rotate
    }()
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(recognizer:)))
    }()
    #elseif os(OSX)
    private lazy var clickGesture: NSClickGestureRecognizer = {
        return NSClickGestureRecognizer(target: self, action: #selector(didClick(recognizer:)))
    }()
    private lazy var magnificationGesture: NSMagnificationGestureRecognizer = {
        return NSMagnificationGestureRecognizer(target: self, action: #selector(didMagnify(recognizer:)))
    }()
    private lazy var panGesture: NSPanGestureRecognizer = {
        return NSPanGestureRecognizer(target: self, action: #selector(didPan(recognizer:)))
    }()
    private lazy var pressGesture: NSPressGestureRecognizer = {
        return NSPressGestureRecognizer(target: self, action: #selector(didPress(recognizer:)))
    }()
    private lazy var rotationGesture: NSRotationGestureRecognizer = {
        return NSRotationGestureRecognizer(target: self, action: #selector(didRotate(recognizer:)))
    }()
    #endif

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
        let g = contextComponents.context()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: height)
        g?.scaleBy(x: 1.0, y: -1.0)
        #endif

        // Setup
        if firstcall {
            self.firstcall = false
            self.delegate?.setup?()
        }

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
        g?.restoreGState()
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
            frameComponents.bounds = self.bounds
        }
    }

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
