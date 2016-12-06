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
    @IBOutlet weak var pointsPlusLabel: UIImageView!
    @IBOutlet weak var pointsMinusLabel: UIImageView!
    @IBOutlet weak var hiCall: UIImageView!
    
    func updateFirstView(){
        self.hiCall.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Hide pointsLabel
        self.pointsPlusLabel.isHidden=true
        self.pointsMinusLabel.isHidden=true
        self.hiCall.isHidden=false
        
        //show hi everyday images
        var _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(CallViewController.updateFirstView), userInfo: nil, repeats: false);

    
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
        
        //Animation
        
        UIView.animate(withDuration: 1.0, animations:{
            self.pointsPlusLabel.isHidden=false
            self.pointsPlusLabel.center.y += 300
            self.pointsPlusLabel.center.x += 320
            self.pointsPlusLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2) },
                       completion:{
                        (finish: Bool) in UIView.animate(withDuration: 0.6, animations:{
                            self.pointsPlusLabel.transform = CGAffineTransform.identity
                            self.pointsPlusLabel.isHidden  = true
                        })
        })


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
        
        //Animation
        
        UIView.animate(withDuration: 1.0, animations:{
            self.pointsMinusLabel.isHidden=false
            self.pointsMinusLabel.center.y += 300
            self.pointsMinusLabel.center.x += 50
            self.pointsMinusLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2) },
                       completion:{
                        (finish: Bool) in UIView.animate(withDuration: 0.6, animations:{
                            self.pointsMinusLabel.transform = CGAffineTransform.identity
                            self.pointsMinusLabel.isHidden  = true
                        })
        })
        
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
