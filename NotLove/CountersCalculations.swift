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
    
    var Counters: [String:AnyObject] {
        return getCounters()
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
            
            
        } catch {
            print("There was an error fetching Minus Operations.")
        }
        
        return (plusTotal-minusTotal)
    }
    
    func getCounters() -> [String:AnyObject]{
        
        let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        let activityFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "StatLog")
        activityFetch.resultType = .dictionaryResultType
        
        
        let sumSteps = NSExpressionDescription()
        sumSteps.name = "sumOfSteps"
        sumSteps.expression = NSExpression(format: "sum:(value)")
        sumSteps.expressionResultType = .doubleAttributeType
        
        let byStattype = NSExpressionDescription()
        byStattype.name = "statType"
        byStattype.expression = NSExpression(format: "statType")
        byStattype.expressionResultType = .stringAttributeType
        
        activityFetch.propertiesToFetch    = [byStattype,sumSteps]
        activityFetch.propertiesToGroupBy  = [byStattype]
        
        var counters : [String:AnyObject] = [:]
        
        // Our result is going to be an array of dictionaries.
        var results:[[String:AnyObject]]?
        
        // Perform the fetch. This is using Swfit 2, so we need a do/try/catch
        do {
            results = try _context.fetch(activityFetch) as? [[String:AnyObject]]
            
            for res in results! {
                
                if let entry_statType = res.first(where: { (key, _) in key.contains("statType") }) {
                    if let entry_value = res.first(where: { (key, _) in key.contains("sumOfSteps") }) {
                        counters[entry_statType.value as! String] = entry_value.value
                    }
                }
            }
            
        } catch _ {
            // If it fails, ensure the array is nil
            results = nil
        }
        return counters
    }


    
}
