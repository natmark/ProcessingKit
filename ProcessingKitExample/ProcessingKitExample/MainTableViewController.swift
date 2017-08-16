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
        case IndexPath(row: 0, section: 0): //Line
            return
        case IndexPath(row: 1, section: 0): //Rect
            return
        case IndexPath(row: 2, section: 0): //Ellipse
            return
        case IndexPath(row: 0, section: 1): //Simple Tap
            let touchSampleViewController = TouchSampleViewController.create()
            self.navigationController?.pushViewController(touchSampleViewController, animated: true)
        case IndexPath(row: 1, section: 1): //Clock Sample
            return
        case IndexPath(row: 0, section: 2): //Physics
            return
        default:
            return
        }
    }

}
