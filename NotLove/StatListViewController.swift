//
//  StatListViewController.swift
//  NotLove
//
//  Created by Oleka on 29/11/16.
//  Copyright © 2016 Olga Blinova. All rights reserved.
//

import UIKit
import CoreData

class StatListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var logs : [StatLog] = []
    
    func getSign(type: Bool) -> String {
        var sign: String = ""
        
        if type == true {
            sign = "+"
        }
        else{
            sign = "-"
        }
        return sign
    }
    
    func getDate (dd:NSDate) -> String {
        
        var dateString: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        dateString = dateFormatter.string(from: dd as Date)
        
        return dateString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate   = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let log = logs[indexPath.row]
        let table_label = "\(getDate(dd: log.dt!))  \(log.name!) = \(getSign(type:log.type))\(log.value)"
        cell.textLabel?.text = table_label
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //Delete stat row
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let log = logs[indexPath.row]
            _context.delete(log)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //update data after deleting
            do{
                logs = try _context.fetch(StatLog.fetchRequest())
            }
            catch{
                print("Fetching Error after deleting!")
            }
            tableView.reloadData()
        }
    }
    
    func getData(){
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            logs = try _context.fetch(StatLog.fetchRequest())
        }
        catch{
            print("Fetching Error!")
        }
        
    }
    
    @IBAction func clearTableView(_ sender: Any) {
        //Delete stat row
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Remove all charging data from persistent storage
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatLog")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try _context.execute(deleteRequest)
        } catch {
            let deleteError = error as NSError
            NSLog("\(deleteError), \(deleteError.localizedDescription)")
        }
        
        //Save
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //update data after deleting
        do{
            logs = try _context.fetch(StatLog.fetchRequest())
        }
        catch{
            print("Fetching Error after deleting!")
        }
        tableView.reloadData()
        
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}
