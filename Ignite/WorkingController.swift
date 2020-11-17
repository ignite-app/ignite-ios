//
//  WorkingController.swift
//  Ignite
//
//  Created by ageor0114 on 10/21/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit
import CountdownLabel

class WorkingController: UIViewController {
    
    @IBOutlet weak var goalLabel: UILabel!

    @IBOutlet weak var countdownTimer: CountdownLabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var popup: UIView!
    var goalModel: GoalTextModel?
    
    var totalTime = Double(0)
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalLabel.text = goalModel?.goalText
        countdownTimer.setCountDownTime(minutes: 10)
//        countdownTimer.animationType = .Burn
        self.totalTime = countdownTimer.timeRemaining
        countdownTimer.start()
        
        progressView.transform = progressView.transform.scaledBy(x: 1.5, y: 5)
        let progress = Progress()
        progressView.observedProgress = progress
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateProgressBar), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateProgressBar() {
        let percentage = ((self.countdownTimer.timeRemaining)/(self.totalTime))
        self.progressView.setProgress(Float(percentage), animated: true)
        //print(self.countdownTimer.timeRemaining)
        if (self.countdownTimer.isPaused) {
            self.countdownTimer.addTime(time: 1)
        }
        if (self.countdownTimer.timeRemaining == 0) {
            self.countdownTimer.pause()
            self.timerZero()
        }
    }

    func timerZero() {
        if timer != nil {
          timer!.invalidate()
          timer = nil
        }
        self.performSegue(withIdentifier: "showReflection", sender: nil)
        
    }

    @IBAction func pressFinished(_ sender: Any) {
        countdownTimer.pause()
        self.performSegue(withIdentifier: "showReflection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReflection" {
            if let destination = segue.destination as? ReflectionController {
                destination.goalModel = goalModel
            }
        }
    }
    @IBAction func closePopup(_ sender: Any) {
    }
    @IBAction func pressYesPopup(_ sender: Any) {
    }
    @IBAction func pressNoPopup(_ sender: Any) {
    }
    
}
