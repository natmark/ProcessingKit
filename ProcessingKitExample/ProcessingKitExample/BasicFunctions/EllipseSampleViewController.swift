//
//  EllipseSampleViewController.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit

class EllipseSampleViewController: UIViewController {

    @IBOutlet weak var ellipseSampleView: EllipseSampleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ellipseSampleView.delegate = ellipseSampleView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
