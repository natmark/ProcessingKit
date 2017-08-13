//
//  PxView.swift
//  PxSwift
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

@objc public protocol PxViewDelegate {
    @objc optional func setup()
    @objc optional func draw()

    @objc optional func fingerTapped()
    @objc optional func fingerMoved()
    @objc optional func fingerReleased()
}

open class PxView: UIImageView {
    // MARK: public properties
    public var touchX: CGFloat = 0.0
    public var touchY: CGFloat = 0.0
    public var fingerPressed: Bool = false

    public var delegate: PxViewDelegate? = nil

    // MARK: internal properties
    var colorComponents = ColorComponents()
    var eventComponents = EventComponents()
    var textComponents = TextComponents()
    var frameComponents = FrameComponents()
    var timer: Timer? = nil

    // Flag for setup function (setup function execute only once)
    fileprivate var firstcall: Bool = true

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
        self.isUserInteractionEnabled = true
    }

    private func run() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0 / frameComponents.frameRate_), target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
    }

    func update(timer: Timer) {
        self.draw(self.frame)
    }

    open override func draw(_ rect: CGRect) {
        UIGraphicsBeginImageContext(rect.size)
        self.image?.draw(at: CGPoint(x: 0, y: 0))
        // setup
        if(firstcall) {
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
    }
}
