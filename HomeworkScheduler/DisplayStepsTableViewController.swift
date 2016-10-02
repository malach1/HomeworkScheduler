//
//  DisplayStepsTableViewController.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 2/25/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

class DisplayStepsTableViewController: UITableViewController {
    
    // MARK: PROPERTIES

    var listOfSteps = [(String, Bool)]()
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfSteps.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("displayStepsCell", forIndexPath: indexPath)
        cell.textLabel!.text = "\(indexPath.row + 1). \(listOfSteps[indexPath.row].0)"
      
        if listOfSteps[indexPath.row].1 == true {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if listOfSteps[indexPath.row].1 == true {
            listOfSteps[indexPath.row].1 = false
        } else {
            listOfSteps[indexPath.row].1 = true
        }
        
        modifiedSteps = listOfSteps
        tableView.reloadData()
    }
}
