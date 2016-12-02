//
//  CallViewController.swift
//  NotLove
//
//  Created by Oleka on 29/11/16.
//  Copyright © 2016 Olga Blinova. All rights reserved.
//

import UIKit

class CallViewController: UIViewController {
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var callsCounterLabel: UILabel!
    @IBOutlet weak var progressCounterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Culculate Progress Points
        let progressPoints = CountersCalculations().ProgressPoints
        
        
        if (progressPoints != 0) {
            self.progressCounterLabel.text =  String(describing: progressPoints)
            if (progressPoints<0){
                self.progressCounterLabel.textColor = .red
            }
            else{
                self.progressCounterLabel.textColor = UIColor(red: 64/255, green: 128/255, blue: 0/255, alpha: 1.0)
            }
        }
        else{
            self.progressCounterLabel.text =  "0"
        }
        
        //Set Call Counter
        let cnt = CountersCalculations().Counters
        if let call_cnt = cnt.first(where: { (key, _) in key.contains("call") }) {
            self.callsCounterLabel.text =  String(describing: (call_cnt.value as! Int)/150)
            
        }
        else{
            self.callsCounterLabel.text =  "0"
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addNoCall(_ sender: Any) {
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //Add into StatLog
        let log = StatLog(context: _context)
        log.dt = NSDate()
        log.value = 50
        log.name = "😶 +1 no call"
        log.type = true
        log.statType = "no_c"
        
        
        //Save data to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //Culculate Progress Points
        let progressPoints = CountersCalculations().ProgressPoints
        
        
        if (progressPoints != 0) {
            self.progressCounterLabel.text =  String(describing: progressPoints)
            if (progressPoints<0){
                self.progressCounterLabel.textColor = .red
            }
            else{
                self.progressCounterLabel.textColor = UIColor(red: 64/255, green: 128/255, blue: 0/255, alpha: 1.0)
            }
        }
        else{
            self.progressCounterLabel.text =  "0"
        }

    }
    @IBAction func addCall(_ sender: Any) {
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //Add into StatLog
        let log = StatLog(context: _context)
        log.dt = NSDate()
        log.value = 150
        log.name = "📞 +1 call"
        log.type = false
        log.statType = "call"
        
        
        //Save data to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //Culculate Progress Points
        let progressPoints = CountersCalculations().ProgressPoints
        
        
        if (progressPoints != 0) {
            self.progressCounterLabel.text =  String(describing: progressPoints)
            if (progressPoints<0){
                self.progressCounterLabel.textColor = .red
            }
            else{
                self.progressCounterLabel.textColor = UIColor(red: 64/255, green: 128/255, blue: 0/255, alpha: 1.0)
            }
        }
        else{
            self.progressCounterLabel.text =  "0"
        }
        
        //Set Call Counter
        let cnt = CountersCalculations().Counters
        if let call_cnt = cnt.first(where: { (key, _) in key.contains("call") }) {
            self.callsCounterLabel.text =  String(describing: (call_cnt.value as! Int)/150)
            
        }
        else{
            self.callsCounterLabel.text =  "0"
        }

    }
}
