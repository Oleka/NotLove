//
//  ThoughtsViewController.swift
//  NotLove
//
//  Created by Oleka on 29/11/16.
//  Copyright © 2016 Olga Blinova. All rights reserved.
//

import UIKit

class ThoughtsViewController: UIViewController {
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var thoughtsCounterLabel: UILabel!
    @IBOutlet weak var progressCounterLabel: UILabel!
    @IBOutlet weak var pointsLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Hide pointsLabel
        self.pointsLabel.isHidden=true
        
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
        
        //Set Thought Counter
        let cnt = CountersCalculations().Counters
        if let thought_cnt = cnt.first(where: { (key, _) in key.contains("thought") }) {
            self.thoughtsCounterLabel.text =  String(describing: (thought_cnt.value as! Int)/20)
            
        }
        else{
            self.thoughtsCounterLabel.text =  "0"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func AddThought(_ sender: Any) {
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //Add into StatLog
        let log = StatLog(context: _context)
        log.dt = NSDate()
        log.value = 20
        log.name = "🤔 +1 thought"
        log.type = false
        log.statType = "thought"
        
        
        //Save data to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //And Update Counters view
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
        
        //Update Thought Counter
        let cnt = CountersCalculations().Counters
        if let thought_cnt = cnt.first(where: { (key, _) in key.contains("thought") }) {
            self.thoughtsCounterLabel.text =  String(describing: (thought_cnt.value as! Int)/20)
            
        }
        else{
            self.thoughtsCounterLabel.text =  "0"
        }
        
        //Animation
//        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
//            // this will change Y position of your imageView center
//            // by 1 every time you press button
//            self.pointsLabel.isHidden=false
//            self.pointsLabel.center.y += 250
//            self.pointsLabel.center.x += 100
//            
//        }, completion: nil)
        
        //
        UIView.animate(withDuration: 1.0, animations:{
            self.pointsLabel.isHidden=false
            self.pointsLabel.center.y += 300
            self.pointsLabel.center.x += 150
            self.pointsLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) },
                                          completion:{
            (finish: Bool) in UIView.animate(withDuration: 0.6, animations:{
            self.pointsLabel.transform = CGAffineTransform.identity
            self.pointsLabel.isHidden  = true
            })
        })
        
    }
}
