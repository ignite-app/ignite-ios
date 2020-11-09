//
//  DarePromptController.swift
//  Ignite
//
//  Created by ageor0114 on 10/21/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit

class DarePromptController: UIViewController {
    
    var goalModel: GoalTextModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func returnGoalPromptButton(_ sender: Any) {
    }
    
    @IBAction func submitDare(_ sender: Any) {
        performSegue(withIdentifier: "showConfirmation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showConfirmation" {
            if let destination = segue.destination as? ConfirmationController {
                destination.goalModel = goalModel
            }
        }
    }
    
}
