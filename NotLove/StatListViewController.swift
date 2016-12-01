//
//  StatListViewController.swift
//  NotLove
//
//  Created by Oleka on 29/11/16.
//  Copyright © 2016 Olga Blinova. All rights reserved.
//

import UIKit

class StatListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var logs : [StatLog] = []
    
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
        let table_label = "\(log.dt!) \(log.name!) \(log.value)"
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
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}
