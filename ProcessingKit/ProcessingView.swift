//
//  ProcessingView.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

#if !os(iOS)
import Cocoa
#endif

import Foundation

@objc public protocol ProcessingViewDelegate {
    @objc optional func setup()
    @objc optional func draw()

    @objc optional func fingerTapped()
    @objc optional func fingerMoved()
    @objc optional func fingerReleased()
}

open class ProcessingView: UIImageView, ProcessingViewDelegate {

    public weak var delegate: ProcessingViewDelegate?
    public var autoRelease: Bool = true
    public var isPlayground: Bool = false

    // MARK: Internal properties
    lazy var frameModel: FrameModelContract = {
        return FrameModel(
            frameComponents: self.frameComponents,
            timer: self.timer
        )
    }()
    lazy var shapeModel: ShapeModelContract = {
        return ShapeModel(
            colorComponents: self.colorComponents
        )
    }()
    lazy var vertexModel: VertexModelContract = {
        return VertexModel(
            vertexComponents: self.vertexComponents,
            colorComponents: self.colorComponents
        )
    }()
    lazy var eventModel: EventModelContract = {
        return EventModel(
            frameComponents: self.frameComponents,
            eventComponents: self.eventComponents
        )
    }()
    lazy var dateModel: DateModelContract = {
        return DateModel()
    }()
    lazy var colorModel: ColorModelContract = {
        return ColorModel(
            colorComponents: self.colorComponents,
            frameComponents: self.frameComponents
        )
    }()
    lazy var textModel: TextModelContract = {
        return TextModel(
            frameComponents: self.frameComponents,
            textComponents: self.textComponents,
            colorComponents: self.colorComponents
        )
    }()
    lazy var imageModel: ImageModelContract = {
        return ImageModel()
    }()

    lazy var transformModel: TransformModelContract = {
        return TransformModel()
    }()

    lazy var timer: Timer? = nil

    // MARK: Private properties
    private var colorComponents = ColorComponents()
    private var eventComponents = EventComponents()
    private var vertexComponents = VertexComponents()
    private var textComponents = TextComponents()
    private var frameComponents = FrameComponents()

    // Flag for setup function (setup function execute only once)
    private var firstcall: Bool = true

    // MARK: - Initializer
    public init() {
        super.init(frame: CGRect.zero)
        self.configuration()
        self.run()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configuration()
        self.run()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuration()
        self.run()
    }

    private func configuration() {
        #if os(iOS)
        self.isUserInteractionEnabled = true
        #endif
        self.delegate = self
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
            self.image?.draw(at: CGPoint(x: 0, y: 0))
        #else
            self.image?.lockFocus()
        #endif

        // Setup
        if firstcall {
            self.firstcall = false
            self.delegate?.setup?()
        }

        // Touch events
        if self.eventComponents.fingerTapped {
            self.eventComponents.fingerTapped = false
            self.delegate?.fingerTapped?()
        }
        if self.eventComponents.fingerMoved {
            self.eventComponents.fingerMoved = false
            self.delegate?.fingerMoved?()
        }
        if self.eventComponents.fingerReleased {
            self.eventComponents.fingerReleased = false
            self.delegate?.fingerReleased?()
        }

        // Draw
        self.frameComponents.frameCount += 1
        self.delegate?.draw?()

        #if os(iOS)
            let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
            self.image = drawnImage
            UIGraphicsEndImageContext()
        #else
            guard let cgImage = NSGraphicsContext.current()?.cgContext.makeImage() else { return }
            self.image = NSImage(cgImage: cgImage, size: self.frame.size)
            //self.image?.unlockFocus()
        #endif

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
