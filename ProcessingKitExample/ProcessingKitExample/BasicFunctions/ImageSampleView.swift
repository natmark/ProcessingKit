//
//  ImageSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/09/27.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import ProcessingKit

class ImageSampleView : ProcessingView {
    func setup() {
        image(UIImage(named: "ProcessingKit-Logo")!, 0, 100, width, 100)
    }
}
