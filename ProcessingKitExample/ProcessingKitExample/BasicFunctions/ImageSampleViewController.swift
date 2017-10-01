//
//  ImageSampleViewController.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/09/27.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit

class ImageSampleViewController: UIViewController {

    @IBOutlet var imageSampleView: ImageSampleView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageSampleView.delegate = imageSampleView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
