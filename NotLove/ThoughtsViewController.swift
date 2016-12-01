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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Culculate Progress Points
//        let progressPoints = calculateProgressPoints()
//        if (progressPoints != 0) {
//            self.progressCounterLabel.text =  String(describing: progressPoints)
//            if (progressPoints<0){
//                self.progressCounterLabel.textColor = .red
//            }
//            else{
//                self.progressCounterLabel.textColor = UIColor(red: 64/255, green: 128/255, blue: 0/255, alpha: 1.0)
//            }
//        }
//        else{
//            self.progressCounterLabel.text =  "0"
//        }
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
        log.name = "😴 +1 thought"
        log.type = false
        log.statType = "thought"
        
        
        //Save data to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
}
