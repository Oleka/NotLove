//
//  NoContactDaysViewController.swift
//  NotLove
//
//  Created by Oleka on 29/11/16.
//  Copyright © 2016 Olga Blinova. All rights reserved.
//

import UIKit

class NoContactDaysViewController: UIViewController {
    
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var lastContactDateLabel: UILabel!
    @IBOutlet weak var no_contact_daysCounterLabel: UILabel!
    @IBOutlet weak var progressCounterLabel: UILabel!
    
    func getDate (dd:NSDate) -> String {
        
        var dateString: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        dateString = dateFormatter.string(from: dd as Date)
        
        return dateString
    }
    
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
        
        //Set No Contact Day Counter
        let cnt = CountersCalculations().Counters
        if let days_cnt = cnt.first(where: { (key, _) in key.contains("no_contact_day") }) {
            self.no_contact_daysCounterLabel.text =  String(describing: (days_cnt.value as! Int)/100)
            
        }
        else{
            self.no_contact_daysCounterLabel.text =  "0"
        }
        
        //Set Last Date
        let last_dates = CountersCalculations().Dates
        if let last_date_meeting = last_dates.first(where: { (key, _) in key.contains("meeting") }) {
            self.lastContactDateLabel.text =  getDate(dd: last_date_meeting.value as! NSDate)
        }
        else{
            self.lastContactDateLabel.text =  "-"
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addNoContactDay(_ sender: Any) {
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //Add into StatLog
        let log = StatLog(context: _context)
        log.dt = NSDate()
        log.value = 100
        log.name = "😋 +1 no contact day"
        log.type = true
        log.statType = "no_contact_day"
        
        
        //Save data to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //Update Progress Points
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
        
        //Update No Contact Day Counter
        let cnt = CountersCalculations().Counters
        if let days_cnt = cnt.first(where: { (key, _) in key.contains("no_contact_day") }) {
            self.no_contact_daysCounterLabel.text =  String(describing: (days_cnt.value as! Int)/100)
            
        }
        else{
            self.no_contact_daysCounterLabel.text =  "0"
        }
        
    }
    
    @IBAction func addMeeting(_ sender: Any) {
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //Add into StatLog
        let log = StatLog(context: _context)
        log.dt = NSDate()
        log.value = 500
        log.name = "😥 +1 meeting"
        log.type = false
        log.statType = "meeting"
        
        
        //Save data to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //Set up Last Meeting Date
        self.lastContactDateLabel.text = getDate(dd:NSDate())
        
        //Update Progress Points
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
    
}
