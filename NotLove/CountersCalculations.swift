//
//  CountersCalculations.swift
//  NotLove
//
//  Created by Oleka on 01/12/16.
//  Copyright © 2016 Olga Blinova. All rights reserved.
//

import UIKit
import CoreData

class CountersCalculations {

    var statPlus : [StatLog] = []
    var statMinus : [StatLog] = []
    var ProgressPoints: Int {
        return calculateProgressPoints()
    }
    
    func calculateProgressPoints() -> Int {
        
        var plusTotal: Int16 = 0
        var minusTotal: Int16 = 0
        
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        //Plus
        do {
            
            let request = NSFetchRequest<StatLog>(entityName: "StatLog")
            request.predicate = NSPredicate(format: "type == true")
            statPlus = try _context.fetch(request)
            
            // Calculate the total Plus...
            
            for stat in statPlus {
                
                let pSum = stat.value
                plusTotal = plusTotal + pSum
            }
            print("Total Plus= \(plusTotal)")
            
        } catch {
            print("There was an error fetching Plus Operations.")
        }
        
        //Minus
        do {
            
            let minus_request = NSFetchRequest<StatLog>(entityName: "StatLog")
            minus_request.predicate = NSPredicate(format: "type == false")
            statMinus = try _context.fetch(minus_request)
            
            // Calculate the total Plus...
            
            for stat in statMinus {
                
                let mSum = stat.value
                minusTotal = minusTotal + mSum
            }
            print("Minus Plus= \(minusTotal)")
            
        } catch {
            print("There was an error fetching Minus Operations.")
        }
        
        return (plusTotal-minusTotal)
        
    }

    
}
