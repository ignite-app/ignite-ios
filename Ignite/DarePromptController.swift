//
//  DarePromptController.swift
//  Ignite
//
//  Created by ageor0114 on 10/21/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit

class DarePromptController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var goalModel: GoalTextModel?
    
    @IBOutlet weak var customDare: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customDareText: UITextView!
    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    let dataSource = DaresDataSource()
    
    var dareSet = Set<String>()
    var dareArray = [] as [String]
    var dare = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        while dareSet.count < 4 {
            let randomIndex = Int(arc4random_uniform(UInt32(dataSource.dares.count)))
            dareSet.insert(dataSource.dares[randomIndex])
        }

        dareArray = Array(dareSet)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dare", for: indexPath)
        let backgroundView = UIView()

        cell.textLabel?.text = dareArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor(red: 0.34, green: 0.42, blue: 0.62, alpha: 1.00)
        cell.textLabel?.highlightedTextColor = UIColor.white
        cell.textLabel?.font = UIFont(name:"Poppins", size:13)
        cell.textLabel?.numberOfLines = 0; // line wrap

        cell.backgroundColor = UIColor(red: 0.93, green: 0.95, blue: 1.00, alpha: 1.00) // unselected
        backgroundView.backgroundColor = UIColor(red: 0.34, green: 0.42, blue: 0.62, alpha: 1.00)
        cell.selectedBackgroundView = backgroundView // selected

        // add spacing between cells by adding clear border
        cell.layer.borderWidth = 5.0
        cell.layer.borderColor = tableView.backgroundColor?.cgColor
        cell.layer.cornerRadius = 8.0

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dare = dareArray[indexPath.row]
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func pressClosePopup(_ sender: Any) {
        popup.isHidden = true
    }
    @IBAction func pressOKPopup(_ sender: Any) {
        performSegue(withIdentifier: "showConfirmation", sender: self)
    }

    @IBAction func pressShuffleDares(_ sender: Any) {
        dareSet.removeAll()
        
        while dareSet.count < 4 {
            let randomIndex = Int(arc4random_uniform(UInt32(dataSource.dares.count)))
            dareSet.insert(dataSource.dares[randomIndex])
        }

        dareArray = Array(dareSet)
        tableView.reloadData()
    }
    @IBAction func pressCustomDare(_ sender: Any) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            dare = ""
        }
        popup.isHidden = false
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        
    }
    

    

    @IBAction func returnGoalPromptButton(_ sender: Any) {
        self.performSegue(withIdentifier: "returnGoalPrompt", sender: nil)
    }
    
    @IBAction func submitDare(_ sender: Any) {
        performSegue(withIdentifier: "showConfirmation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showConfirmation" {
            if let destination = segue.destination as? ConfirmationController {
                destination.goalModel = goalModel
                if dare == "" {
                    destination.chosenDare = customDare.text!
                } else if dare != "" {
                    destination.chosenDare = dare
                }
            }
        }
    }
}
