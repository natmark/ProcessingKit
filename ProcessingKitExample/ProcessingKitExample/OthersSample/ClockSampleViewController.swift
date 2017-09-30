//
//  ClockSampleViewController.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/09/30.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit

class ClockSampleViewController: UIViewController {
    @IBOutlet weak var clockSampleView: ClockSampleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clockSampleView.delegate = clockSampleView
        clockSampleView.isUserInteractionEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        clockSampleView.noLoop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
