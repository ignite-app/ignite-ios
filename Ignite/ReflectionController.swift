//
//  ReflectionController.swift
//  Ignite
//
//  Created by ageor0114 on 10/21/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit

class ReflectionController: UIViewController {

    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var reflectionText: UITextView!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var metGoal = false;
    
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

    @IBAction func pressNo(_ sender: Any) {
        if metGoal {
            // Haptic feedback
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            yesButton.backgroundColor = UIColor(red: 0.80, green: 0.86, blue: 1.00, alpha: 1.00)
            yesButton.setTitleColor(UIColor(red: 0.14, green: 0.18, blue: 0.31, alpha: 1.00), for: .normal)

            noButton.backgroundColor = UIColor(red: 0.14, green: 0.18, blue: 0.31, alpha: 1.00)
            noButton.setTitleColor(UIColor(red: 0.80, green: 0.86, blue: 1.00, alpha: 1.00), for: .normal)
            
            metGoal = false
        }
    }
    
    @IBAction func pressYes(_ sender: Any) {
        if !metGoal {
            // Haptic feedback
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            yesButton.backgroundColor = UIColor(red: 0.14, green: 0.18, blue: 0.31, alpha: 1.00)
            yesButton.setTitleColor(UIColor(red: 0.80, green: 0.86, blue: 1.00, alpha: 1.00), for: .normal)
            
            noButton.backgroundColor = UIColor(red: 0.80, green: 0.86, blue: 1.00, alpha: 1.00)
            noButton.setTitleColor(UIColor(red: 0.14, green: 0.18, blue: 0.31, alpha: 1.00), for: .normal)
                
            metGoal = true
        }
    }
    
    @IBAction func submitReflection(_ sender: Any) {
        performSegue(withIdentifier: "showCamera", sender: self)
    }
}
