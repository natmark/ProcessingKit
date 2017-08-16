//
//  MainTableViewController.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case IndexPath(row: 0, section: 0): //Text
            transition(viewController: TextSampleViewController.create())
            return
        case IndexPath(row: 1, section: 0): //Rect
            transition(viewController: RectSampleViewController.create())
            return
        case IndexPath(row: 2, section: 0): //Ellipse
            transition(viewController: EllipseSampleViewController.create())
            return
        case IndexPath(row: 0, section: 1): //Simple Tap
            transition(viewController: TouchSampleViewController.create())
        case IndexPath(row: 0, section: 2): //Particles
            transition(viewController: ParticlesSampleViewController.create())
        case IndexPath(row: 1, section: 2): //Clock Sample
            return
        case IndexPath(row: 2, section: 2): //Physics
            return
        default:
            return
        }
    }
    func transition(viewController: UIViewController){
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
