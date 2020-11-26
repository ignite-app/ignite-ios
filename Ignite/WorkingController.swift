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
    @IBOutlet weak var ropeBurner: UIImageView!
    
    @IBOutlet weak var ropeContainer: UIView!
    @IBOutlet weak var popup: UIView!
    var goalModel: GoalTextModel?
    var originRopeX = CGFloat(0)
    var originRopeBurnerX = CGFloat(0)

    @IBOutlet weak var rope: UIImageView!
    var totalTime = Double(0)
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalLabel.text = goalModel?.goalText
        countdownTimer.setCountDownTime(minutes: 30)

        self.originRopeX = self.rope.center.x
        self.originRopeBurnerX = self.ropeBurner.center.x
        self.totalTime = countdownTimer.timeRemaining
        countdownTimer.start()
        startTimer()
//        createFire()
        self.popup.alpha = 0.95
        //100%
//        self.view.backgroundColor = UIColor(red: 36/255, green: 48/255, blue: 78/255,alpha: 1)
//        self.view.backgroundColor = UIColor(red: 80/255, green: 48/255, blue: 78/255,alpha: 1)
//255, 71, 87
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func createFire() {
            let fireEmitter = CAEmitterLayer()
            fireEmitter.emitterPosition = CGPoint(x: 250, y: 450)
        fireEmitter.emitterSize = CGSize(width: 0.2, height: 0.2);
        fireEmitter.renderMode = CAEmitterLayerRenderMode.additive;
        fireEmitter.emitterShape = CAEmitterLayerEmitterShape.line
            fireEmitter.emitterCells = [createFireCell()];
            
            self.view.layer.addSublayer(fireEmitter)
        }
        
        func createFireCell() -> CAEmitterCell {
            let fire = CAEmitterCell();
            fire.alphaSpeed = -0.3
            fire.birthRate = 5;
            fire.lifetime = 60.0;
            fire.lifetimeRange = 0.5
            fire.color = UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 0.6).cgColor

            fire.contents = UIImage(named: "ropeBurner")?.cgImage
            fire.emissionLongitude = CGFloat(Double.pi);
            fire.velocity = 20;
            fire.velocityRange = 1;
            fire.emissionRange = 0.1;
            fire.yAcceleration = -100;
            fire.scaleSpeed = 0.1;
            
            return fire
        }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateProgressBar), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateProgressBar() {
        
        let percentage = 1/(self.totalTime)
        let timeElapsed = self.totalTime - self.countdownTimer.timeRemaining
        if (!self.countdownTimer.isPaused) {
            print(self.countdownTimer.timeRemaining)
            if (self.countdownTimer.timeRemaining <= 0 && self.popup.isHidden) {
                self.timerZero()
            }
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                let calc = CGFloat(self.rope.frame.width + 2) * CGFloat(percentage) * CGFloat(timeElapsed)
                self.ropeBurner.center.x = self.originRopeBurnerX - calc
                self.rope.center.x = self.originRopeX - calc
            }, completion: nil)
        }
    }

    func timerZero() {
        let state = UIApplication.shared.applicationState
        if state == .active {
            if timer != nil {
              timer!.invalidate()
              timer = nil
            }
            self.rope.isHidden = true
            self.ropeBurner.isHidden = true
            if (self.popup.isHidden) {
                self.performSegue(withIdentifier: "showReflection", sender: nil)
            }
        }
    }

    @IBAction func pressFinished(_ sender: Any) {
        UIView.animate(withDuration: 2, delay: 0.5, options: .curveLinear, animations: {
            self.popup.isHidden = false
        }, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReflection" {
            if let destination = segue.destination as? ReflectionController {
                destination.goalModel = goalModel
            }
        }
    }

    @IBAction func closePopup(_ sender: Any) {
        self.popup.isHidden = true
    }
    @IBAction func pressYesPopup(_ sender: Any) {
        self.performSegue(withIdentifier: "showReflection", sender: self)
    }
    @IBAction func pressNoPopup(_ sender: Any) {
        self.popup.isHidden = true

    }

}


