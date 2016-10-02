//
//  HomeworkTableViewController.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 1/11/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit
import Foundation

var homeworkList = [Homework]()
var selectedFilterType = String()

enum filterValues:String {
    case dueDate
    case classType
    case priority
}

var globalDidComplete = (Int(), Bool())
var globalWasProductive = (Int(), Bool())
var globalTrigger:Bool = false

class HomeworkTableViewController: UITableViewController, filterUpdateDelegate {
    
    // MARK: PROPERTIES
    
    let cellType = "assignmentCell"
    let segueID = "showHomeworkDetail"
    let filterCellType = "sortCell"
    var passData = Homework()
    var sortedDates = [Homework]()
    var sortedClassType = [Homework]()
    var sortedPriority = [Homework]()

    
    // MARK: ACTIONS
    
    @IBAction func refreshTableView(sender: AnyObject) {
        tableView.reloadData()
    }
    
    @IBAction func addHomework(sender: AnyObject) {
        cleanUpSortedArrays()
    }
    
    
    // MARK: FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool){
        if homeworkList.count > 0 {
            sortedDates = sortByDueDate(homeworkList)
            sortedClassType = sortByClassType(homeworkList)
            sortedPriority = sortByPriority(homeworkList)
            
            if globalTrigger == true {
                homeworkList[globalDidComplete.0].didComplete = globalDidComplete.1
                homeworkList[globalWasProductive.0].wasProductive = globalWasProductive.1
                resetGlobalTuple()
            }
        }
        
        for dates in sortedDates {
            print(dates.date)
        }
        
        tableView.reloadData()
        
        if OKbutton == true {
            OKbutton = false
        }
    }
  
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkList.count + 1
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(filterCellType, forIndexPath: indexPath) as! FilterTableViewCell
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
        } else {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellType, forIndexPath: indexPath) as! AssignmentTableViewCell
            homeworkList[indexPath.row-1].homeworkIndex = indexPath.row-1

            switch selectedFilterType{
            case filterValues.classType.rawValue:
                let homeAssignment = sortedClassType[indexPath.row-1]
                cell.assignmentTitleLabel.text = homeAssignment.title
                cell.assignmentDueDateLabel.text = "Due \(homeAssignment.date)"
                let classSelectStyled = homeAssignment.classSelect[0...2]
                cell.assignmentClassLabel.text = classSelectStyled.uppercaseString
                cell.assignmentPriorityLabel.text = homeAssignment.priority.1
                if homeAssignment.didComplete == true{
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
                
            case filterValues.dueDate.rawValue:
                let homeAssignment = sortedDates[indexPath.row-1]
                cell.assignmentTitleLabel.text = homeAssignment.title
                cell.assignmentDueDateLabel.text = "Due \(homeAssignment.date)"
                let classSelectStyled = homeAssignment.classSelect[0...2]
                cell.assignmentClassLabel.text = classSelectStyled.uppercaseString
                cell.assignmentPriorityLabel.text = homeAssignment.priority.1
                if homeAssignment.didComplete == true{
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }

            case filterValues.priority.rawValue:
                let homeAssignment = sortedPriority[indexPath.row-1]
                cell.assignmentTitleLabel.text = homeAssignment.title
                cell.assignmentDueDateLabel.text = "Due \(homeAssignment.date)"
                let classSelectStyled = homeAssignment.classSelect[0...2]
                cell.assignmentClassLabel.text = classSelectStyled.uppercaseString
                cell.assignmentPriorityLabel.text = homeAssignment.priority.1
                if homeAssignment.didComplete == true{
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }

            default:
                let homeAssignment = homeworkList[indexPath.row-1]
                cell.assignmentTitleLabel.text = homeAssignment.title
                cell.assignmentDueDateLabel.text = "Due \(homeAssignment.date)"
                let classSelectStyled = homeAssignment.classSelect[0...2]
                cell.assignmentClassLabel.text = classSelectStyled.uppercaseString
                cell.assignmentPriorityLabel.text = homeAssignment.priority.1
                if homeAssignment.didComplete == true{
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            }
            
            /*if indexPath.row < (homeworkList.count + 1){
                cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            }*/

            return cell
        }
    }
    
    func updateTable() {
        viewWillAppear(true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Homework List"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != 0 {
            switch selectedFilterType{
            case filterValues.classType.rawValue:
                passData = sortedClassType[indexPath.row-1]
                
            case filterValues.dueDate.rawValue:
                passData = sortedDates[indexPath.row-1]
                
            case filterValues.priority.rawValue:
                passData = sortedPriority[indexPath.row-1]
                
            default:
                passData = homeworkList[indexPath.row-1]
            }
            
            performSegueWithIdentifier(segueID, sender: self)
        }
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("hello")
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != 0 {
            homeworkList.removeAtIndex(indexPath.row-1)
            let indexPaths = [indexPath]
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        }
    }
    
    
    // MARK: SORTING
    
    func sortByDueDate(hwList:[Homework]) ->[Homework]{
        sortedDates = hwList.sort {
            return $0.dateFormat.compare($1.dateFormat) == .OrderedAscending
        }
        
        return sortedDates
    }
    
    func sortByClassType(hwList:[Homework]) ->[Homework]{
        sortedClassType = hwList.sort {
            return $0.classSelect < $1.classSelect
        }
        
        return sortedClassType
    }
    
    func sortByPriority(hwList:[Homework]) ->[Homework]{
        sortedPriority = hwList.sort {
            return $0.priority.0 < $1.priority.0
        }
        return sortedPriority
    }
    
    func cleanUpSortedArrays() {
        sortedDates.removeAll()
        sortedClassType.removeAll()
        sortedPriority.removeAll()
    }
    
    func resetGlobalTuple(){
        globalDidComplete.0 = 0
        globalDidComplete.1 = false
        globalWasProductive.0 = 0
        globalWasProductive.1 = false
        globalTrigger = false
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 65
        } else if indexPath.row <= (homeworkList.count){
            return 70
        } else if indexPath.row == (homeworkList.count + 1){
            let bigCellHeight:Int = 568 - 65 - (70 * homeworkList.count)
            return CGFloat(bigCellHeight)
        } else {
            return 70
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
    
    }

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == segueID) {
            let vc = segue.destinationViewController as! HomeworkDetailsTableViewController
            vc.homeworkAssignment = passData
        }
    }
    
}


// MARK: FORMATTING

extension String {
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        
        return self[Range(start: start, end: end)]
    }
}
