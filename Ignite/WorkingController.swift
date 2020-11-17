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
    
    @IBOutlet weak var ropeContainer: UIView!
    

    @IBOutlet weak var rope: UIImageView!
    var goalModel: GoalTextModel?
    var totalTime = Double(0)
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalLabel.text = goalModel?.goalText
        countdownTimer.setCountDownTime(minutes: 30)
//        countdownTimer.animationType = .Burn
        self.totalTime = countdownTimer.timeRemaining
        countdownTimer.start()
        

        startTimer()
        createFire()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//            init(red:0.8, green: 0.4, blue: 0.2, alpha: 0.6);
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

        //print(self.countdownTimer.timeRemaining)
        if (self.countdownTimer.isPaused) {
            self.countdownTimer.addTime(time: 1)
        }
        if (self.countdownTimer.timeRemaining == 0) {
            self.countdownTimer.pause()
            self.timerZero()
        }
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            print(self.rope.center.x)
            print(self.rope.frame.width -         self.rope.frame.width * CGFloat(percentage))
            print(CGFloat(percentage))
            self.rope.center.x -=  CGFloat(self.rope.frame.width + 4) * CGFloat(percentage)
//            self.rope.transform = CGAffineTransform(translationX:-(          self.rope.frame.width * CGFloat(percentage)), y: CGFloat(0))

        }, completion: nil)
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
}


