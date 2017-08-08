//
//  PxView.swift
//  PxSwift
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

public protocol PxViewDelegate {
    func setup()
    func draw()
}

open class PxView : UIImageView {
    //MARK: public properties
    public var width: CGFloat {
        return self.frame.size.width
    }
    public var height: CGFloat {
        return self.frame.size.height
    }

    public var delegate :PxViewDelegate? = nil

    //MARK: internal properties
    var fill_: UIColor = UIColor.white
    var stroke_: UIColor = UIColor.clear
    var strokeWeight_: CGFloat = 1.0

    // Flag for setup function (setup function execute only once)
    fileprivate var firstcall : Bool = true
    
    public init() {
        super.init(frame: CGRect.zero)
        run()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        run()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        run()
    }
    private func run(){
        _ = Timer.scheduledTimer(timeInterval: 1.0 / 60 , target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
    }
    @objc private func update(timer: Timer){
        self.draw(self.frame)
    }
    open override func draw(_ rect: CGRect) {
        UIGraphicsBeginImageContext(rect.size)
        self.image?.draw(at: CGPoint(x: 0, y: 0))
        if(firstcall) {
            firstcall = false
            delegate?.setup()
        }
        
        delegate?.draw()
        let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
        self.image = drawnImage
    }
}
