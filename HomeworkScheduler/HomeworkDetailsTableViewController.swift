//
//  HomeworkDetailsTableViewController.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 1/11/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

var modifiedSteps = [(String, Bool)]()

class HomeworkDetailsTableViewController: UITableViewController {
    
    // MARK: PROPERTIES
    
    var homeworkAssignment = Homework()
    var workID = "showWork"
    var stepsID = "displayStepsSegue"
    
    
    // MARK: ACTIONS
    
    @IBAction func displayStepsBtn(sender: UIButton) {
        performSegueWithIdentifier(stepsID, sender: self)
    }
    
    
    // MARK: FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(homeworkAssignment.title)"
        navigationItem.backBarButtonItem?.title = "List"
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        if modifiedSteps.count > 0 {
            homeworkAssignment.steps = modifiedSteps
            modifiedSteps.removeAll()
            stepList.removeAll()
        }
        tableView.reloadData()
        
        if OKbutton == true {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later")&&(homeworkAssignment.details != "") && (homeworkAssignment.steps.count != 0) {
            return 6

        } else if ((homeworkAssignment.details == "Write notes about assignments here - details you want to remember for later") || (homeworkAssignment.details == "")) && (homeworkAssignment.steps.count != 0) {
            return 5
        
        } else if ((homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later") && (homeworkAssignment.details != "")) && (homeworkAssignment.steps.count == 0){
            return 5
        } else {
            return 4
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 3) && ((homeworkAssignment.details == "Write notes about assignments here - details you want to remember for later") || (homeworkAssignment.details == "")) && homeworkAssignment.steps.count == 0{
            performSegueWithIdentifier(workID, sender: self)

        } else if (indexPath.row == 4) && ((homeworkAssignment.details == "Write notes about assignments here - details you want to remember for later") || (homeworkAssignment.details == "")) && homeworkAssignment.steps.count != 0 {
            performSegueWithIdentifier(workID, sender: self)
        } else if (indexPath.row == 4) && (homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later") && (homeworkAssignment.details != "") && (homeworkAssignment.steps.count == 0){
            performSegueWithIdentifier(workID, sender: self)
        } else if (indexPath.row == 5) && (homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later") && (homeworkAssignment.details != "") && (homeworkAssignment.steps.count != 0) {
            performSegueWithIdentifier(workID, sender: self)
        } else {
            print("uhok")
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("homeworkDetailCell", forIndexPath: indexPath) as! HomeworkDetailsTableViewCell
        
            if indexPath.row == 0 {
                cell.assignmentDetail.text = "Due: \(homeworkAssignment.date)"
                cell.assignmentDetail.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            } else if indexPath.row == 1 {
                cell.assignmentDetail.text = "Priority: \(homeworkAssignment.priority.1)"
                cell.assignmentDetail.textColor = UIColor(red: (128/255.0), green: 0, blue: 1, alpha: 1)
            } else if indexPath.row == 2 {
                cell.assignmentDetail.text = "Class: \(homeworkAssignment.classSelect)"
                cell.assignmentDetail.textColor = UIColor(red: 0, green: (128/255.0), blue: 1, alpha: 1)
            }

            return cell
        } else if (indexPath.row == 3) {
        
            if (homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later")&&(homeworkAssignment.details != "") {
                
            let cell = tableView.dequeueReusableCellWithIdentifier("notesCell", forIndexPath: indexPath) as! HomeworkNotesDetailTableViewCell
              cell.notesLbl.text = "\(homeworkAssignment.details)"
                
                return cell

            } else if homeworkAssignment.steps.count != 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("stepsCell", forIndexPath: indexPath) as! HomeworkStepsDetailTableViewCell
                let stepsCompleted = countStepsCompleted(homeworkAssignment.steps)
                
                cell.completeVsAllStepsLbl.text = "\(stepsCompleted)/\(homeworkAssignment.steps.count)"
                cell.showSteps.enabled = true
                
                return cell

            } else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("workCell", forIndexPath: indexPath) as! HomeworkWorkBtnTableViewCell
                
                return cell


            }
    
        } else if indexPath.row == 4 {
            
            if ((homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later")&&(homeworkAssignment.details != "")) && (homeworkAssignment.steps.count != 0){
                
                let cell = tableView.dequeueReusableCellWithIdentifier("stepsCell", forIndexPath: indexPath) as! HomeworkStepsDetailTableViewCell
                let stepsCompleted = countStepsCompleted(homeworkAssignment.steps)
                cell.completeVsAllStepsLbl.text = "\(stepsCompleted)/\(homeworkAssignment.steps.count)"
                cell.showSteps.enabled = true
                
                return cell

            } else if ((homeworkAssignment.details == "Write notes about assignments here - details you want to remember for later") || (homeworkAssignment.details == "")) && (homeworkAssignment.steps.count != 0) {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("workCell", forIndexPath: indexPath) as! HomeworkWorkBtnTableViewCell
                
                return cell
            } else if ((homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later") && (homeworkAssignment.details != "")) && (homeworkAssignment.steps.count == 0) {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("workCell", forIndexPath: indexPath) as! HomeworkWorkBtnTableViewCell
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath)
                
                return cell
            }
            
        } else if indexPath.row == 5 {
            
             if ((homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later")&&(homeworkAssignment.details != "")) && (homeworkAssignment.steps.count != 0){
                
                let cell = tableView.dequeueReusableCellWithIdentifier("workCell", forIndexPath: indexPath) as! HomeworkWorkBtnTableViewCell
                
                return cell
                
             } else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath)
                
                return cell
            }
            
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath)
            
            return cell
        }
    }

    func countStepsCompleted(steps: [(String, Bool)]) -> Int{
        var checkMarkCount = 0
        
        for steps in steps {
            if steps.1 == true {
                checkMarkCount++
            }
        }
        
        return checkMarkCount
    }
    
    /*
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later")&&(homeworkAssignment.details != "") && (homeworkAssignment.steps.count != 0) {
                if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
                    return 60
                } else if indexPath.row == 4 {
                    return 60
                } else if indexPath.row == 5 {
                    return 60
                } else if indexPath.row > 5{
                    return 60
                }

        } else if ((homeworkAssignment.details == "Write notes about assignments here - details you want to remember for later") || (homeworkAssignment.details == "")) && (homeworkAssignment.steps.count != 0) {
            
               return 60
            
        } else if ((homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later") && (homeworkAssignment.details != "")) && (homeworkAssignment.steps.count == 0) {
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
                return 60
            } else if indexPath.row == 4 {
                return 60
            } else if indexPath.row == 5 {
                return 60
            } else if indexPath.row > 5{
                return 60
            }

        } else if (homeworkAssignment.details != "Write notes about assignments here - details you want to remember for later")&&(homeworkAssignment.details != "") && (homeworkAssignment.steps.count != 0) {
            return 60
        } else {
            return 60
        }
        
        return 100
    }
    */
    
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == workID) {
            let vc = segue.destinationViewController as! WorkViewController
            vc.passedHomeworkModel = homeworkAssignment
        } else if (segue.identifier == stepsID) {
            let vc = segue.destinationViewController as! DisplayStepsTableViewController
            vc.listOfSteps = homeworkAssignment.steps
        }
    }
}
