//
//  GoalPromptController.swift
//  Ignite
//
//  Created by ageor0114 on 10/17/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit

class GoalPromptController: UIViewController {

    @IBOutlet weak var welcomeTitle: UILabel!
    
    @IBOutlet weak var goalText: UITextView!
    
    @IBOutlet weak var timeText: UITextField!
    
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

    @IBAction func returnLandingButton(_ sender: Any) {
        self.performSegue(withIdentifier: "returnLanding", sender: nil)
    }
    
    @IBAction func submitGoal(_ sender: Any) {
        self.performSegue(withIdentifier: "showDarePrompt", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDarePrompt" {
            if let destination = segue.destination as? DarePromptController {
                destination.goalModel = GoalTextModel(goalText: goalText.text)
            }
        }
    }
}
