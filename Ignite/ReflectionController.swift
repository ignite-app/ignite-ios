//
//  ReflectionController.swift
//  Ignite
//
//  Created by ageor0114 on 10/21/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit
import CoreData

class ReflectionController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var reflectionText: UITextView!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var goalModel: GoalTextModel?
    
    var metGoal = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalLabel.text = goalModel?.goalText
        
        // Move view up/down when keyboard is opened/closed, respectively
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Tap to close keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Core Data testing
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LogEntry")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                //print("Goal: \(String(describing: data.value(forKey: "goal")!)), Completed: \(String(describing: data.value(forKey: "didCompleteGoal")!))")
            }
        } catch {
            print("LogEntry retrieval failed.")
        }
        
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
        
        // Save task to core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LogEntry", in: context)
        let logEntry = NSManagedObject(entity: entity!, insertInto: context)
        
        logEntry.setValue(self.metGoal, forKey: "didCompleteGoal")
        logEntry.setValue(self.goalModel!.goalText, forKey: "goal")
        logEntry.setValue(self.reflectionText.text, forKey: "reflection")
        logEntry.setValue(nil, forKey: "completedTime")
        logEntry.setValue(nil, forKey: "totalTime")
       
        do {
            try context.save()
        } catch {
            print("Failed to save entry")
        }

        performSegue(withIdentifier: "showCamera", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCamera" {
            if let destination = segue.destination as? CameraController {
                destination.goalModel = goalModel
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/3
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
