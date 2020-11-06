//
//  ReflectionController.swift
//  Ignite
//
//  Created by ageor0114 on 10/21/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit

class ReflectionController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var reflectionText: UITextView!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var metGoal = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Move view up/down when keyboard is opened/closed, respectively
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Tap to close keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
