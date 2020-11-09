//
//  ViewController.swift
//  Ignite
//
//  Created by ageor0114 on 10/17/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getStarted(_ sender: Any) {
        self.performSegue(withIdentifier: "showGoalPrompt", sender: nil)
    }
    
}

