//
//  ProcessingView.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

@objc public protocol ProcessingViewDelegate {
    @objc optional func setup()
    @objc optional func draw()

    @objc optional func fingerTapped()
    @objc optional func fingerMoved()
    @objc optional func fingerReleased()
}

open class ProcessingView: UIImageView {

    public weak var delegate: ProcessingViewDelegate? = nil

    // MARK: internal properties
    var loopModel: LoopModelContractor!
    var frameModel: FrameModelContractor!
    var shapeModel: ShapeModelContractor!
    var eventModel: EventModelContractor!
    var colorModel: ColorModelContractor!
    var textModel: TextModelContractor!
    var imageModel: ImageModelContractor!
    var timer: Timer? = nil

    // MARK: fileprivate properties
    fileprivate var colorComponents = ColorComponents()
    fileprivate var eventComponents = EventComponents()
    fileprivate var textComponents = TextComponents()
    fileprivate var frameComponents = FrameComponents()

    // Flag for setup function (setup function execute only once)
    fileprivate var firstcall: Bool = true

    public init() {
        super.init(frame: CGRect.zero)
        self.configuration()
        self.run()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializer()
        self.configuration()
        self.run()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializer()
        self.configuration()
        self.run()
    }

    private func initializer() {
        frameModel = FrameModel(frameComponents: self.frameComponents, timer: self.timer)
        shapeModel = ShapeModel(colorComponents: self.colorComponents)
        eventModel = EventModel(processingView: self, eventComponents: self.eventComponents)
        colorModel = ColorModel(processingView: self, colorComponents: self.colorComponents)
        textModel = TextModel(processingView: self, textComponents: self.textComponents, colorComponents: self.colorComponents)
        imageModel = ImageModel()
    }

    private func configuration() {
        self.isUserInteractionEnabled = true
    }

    @objc private func suspend(notification: NSNotification) {
        self.noLoop()
    }

    @objc private func resume(notification: NSNotification) {
        self.loop()
    }

    private func run() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0 / frameComponents.frameRate), target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
    }

    @objc fileprivate func update(timer: Timer) {
        self.draw(self.frame)
    }

    open override func draw(_ rect: CGRect) {
        UIGraphicsBeginImageContext(rect.size)
        self.image?.draw(at: CGPoint(x: 0, y: 0))
        // setup
        if firstcall {
            self.firstcall = false
            self.delegate?.setup?()
        }
        // touch events
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

        // draw
        self.delegate?.draw?()
        let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
        self.image = drawnImage

        guard let _ = self.delegate?.draw else {
            self.timer?.invalidate()
            return
        }
    }
}

// MARK: - Extensions

extension ProcessingView {
    public func frameRate(_ fps: CGFloat) {
        self.frameModel.frameRate(fps)

        self.timer?.invalidate()
        self.timer = nil
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0 / frameComponents.frameRate), target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
    }
}
