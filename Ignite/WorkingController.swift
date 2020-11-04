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
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownTimer.setCountDownTime(minutes: 60*60)
        countdownTimer.start()
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

    @IBAction func pressFinished(_ sender: Any) {
        self.performSegue(withIdentifier: "showReflection", sender: self)
    }
    
}
