//
//  StepsTableViewController.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 1/25/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

 var stepList = [(String, Bool)]()

class StepsTableViewController: UITableViewController {
    
    // MARK: ACTIONS
    
    @IBAction func addStepsBtnPressed(sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("get step") as! AddStepsViewController
    }

    @IBAction func doneStepsBtnPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    
    // MARK: FUNCTIONS
    
    override func viewWillAppear(animated: Bool) {
        print("should have step")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stepCell", forIndexPath: indexPath)
        cell.textLabel!.text = "\(indexPath.row+1). \(stepList[indexPath.row].0)"
        
        return cell
    }
}
