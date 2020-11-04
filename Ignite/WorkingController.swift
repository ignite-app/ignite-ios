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
    var totalTime = Double(0)
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownTimer.setCountDownTime(minutes: 10)
//        countdownTimer.animationType = .Burn
        self.totalTime = countdownTimer.timeRemaining
        countdownTimer.start()
        progressView.setProgress(Float(1), animated: false)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 5)
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
        print(self.countdownTimer.timeRemaining)
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
        self.performSegue(withIdentifier: "showReflection", sender: self)
    }
    
}
