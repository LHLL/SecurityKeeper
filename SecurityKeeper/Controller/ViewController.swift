//
//  ViewController.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AssetPicker.shared.showImagePicker()
    }
}

