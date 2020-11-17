//
//  ConfirmationController.swift
//  Ignite
//
//  Created by ageor0114 on 10/21/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit

class ConfirmationController: UIViewController {
    
    var goalModel: GoalTextModel?
    var chosenDare: String = ""
    
    @IBOutlet var goalLabel: UILabel!
    @IBOutlet weak var dareLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalLabel?.text = goalModel?.goalText
        dareLabel.text = "You've agreed to '\(chosenDare)'."
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
    
    @IBAction func returnDarePromptButton(_ sender: Any) {
        self.performSegue(withIdentifier: "returnDarePrompt", sender: nil)
    }
    
    @IBAction func startWorking(_ sender: Any) {
        self.performSegue(withIdentifier: "showWorking", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWorking" {
            if let destination = segue.destination as? WorkingController {
                destination.goalModel = goalModel
            }
        }
    }
    
}
