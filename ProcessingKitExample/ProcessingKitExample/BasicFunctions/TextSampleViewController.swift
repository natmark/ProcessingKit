//
//  LineSampleViewController.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit

class TextSampleViewController: UIViewController {

    @IBOutlet weak var textSampleView: TextSampleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textSampleView.delegate = textSampleView
    }

    override func viewWillDisappear(_ animated: Bool) {
        textSampleView.noLoop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
