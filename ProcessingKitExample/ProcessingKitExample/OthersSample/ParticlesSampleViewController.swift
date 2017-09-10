//
//  ParticlesSampleViewController.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/17.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit

class ParticlesSampleViewController: UIViewController {

    @IBOutlet weak var particlesSampleView: ParticlesSampleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        particlesSampleView.delegate = particlesSampleView
        particlesSampleView.isUserInteractionEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        particlesSampleView.noLoop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
