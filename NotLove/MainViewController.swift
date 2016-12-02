//
//  ViewController.swift
//  NotLove
//
//  Created by Oleka on 11/11/16.
//  Copyright © 2016 Olga Blinova. All rights reserved.
//

import UIKit
import CoreData

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}


class MainViewController: UIViewController {
    
    var statPlus : [StatLog] = []
    var statMinus : [StatLog] = []
    
    @IBOutlet weak var progressCounterLabel: UILabel!
    
    @IBOutlet weak var noContactDayCounterLabel: UILabel!
    
    @IBOutlet weak var thoughtsCounterLabel: UILabel!
    
    @IBOutlet weak var callsCounterLabel: UILabel!
    
    @IBOutlet weak var messagesCounterLabel: UILabel!
    
    @IBOutlet weak var meetsCounterLabel: UILabel!
    
    
    
    
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
        
        
        //Get counters
        let cnt = CountersCalculations().Counters
        
        //Set Thought Counter
        if let thought_cnt = cnt.first(where: { (key, _) in key.contains("thought") }) {
            self.thoughtsCounterLabel.text =  String(describing: (thought_cnt.value as! Int)/20)
            
        }
        else{
            self.thoughtsCounterLabel.text =  "0"
        }
        
        //Set no_contact_day Counter
        if let no_contact_day_cnt = cnt.first(where: { (key, _) in key.contains("no_contact_day") }) {
            self.noContactDayCounterLabel.text = String(describing:(no_contact_day_cnt.value as! Int)/100)
        }
        else{
            self.noContactDayCounterLabel.text = "0"
        }

        //Set Call Counter
        if let calls_cnt = cnt.first(where: { (key, _) in key.contains("call") }) {
            self.callsCounterLabel.text = String(describing:(calls_cnt.value as! Int)/150)
        }
        else{
            self.callsCounterLabel.text = "0"
        }

        //Set Messages Counter
        if let messages_cnt = cnt.first(where: { (key, _) in key.contains("message") }) {
            self.messagesCounterLabel.text = String(describing:(messages_cnt.value as! Int)/100)
        }
        else{
            self.messagesCounterLabel.text = "0"
        }

        //Set Meets Counter
        if let meets_cnt = cnt.first(where: { (key, _) in key.contains("meeting") }) {
            self.meetsCounterLabel.text = String(describing:(meets_cnt.value as! Int)/500)
        }
        else{
            self.meetsCounterLabel.text = "0"
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

