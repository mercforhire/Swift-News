//
//  BaseViewController.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import UIKit

// This is the default generic view controller that all other view controllers should inherit from in the project
class BaseViewController: UIViewController {
    var vcFactory: VCFactory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
