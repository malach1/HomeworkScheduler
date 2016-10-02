//
//  FilterTableViewCell.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 3/7/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES
    
    var delegate:filterUpdateDelegate?
    
    
    // MARK: ACTIONS
    
    @IBAction func filterValueChanged(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1 {
            selectedFilterType = filterValues.dueDate.rawValue
            print(selectedFilterType)
        } else if sender.selectedSegmentIndex == 2 {
            selectedFilterType = filterValues.classType.rawValue
        } else if sender.selectedSegmentIndex == 3 {
            selectedFilterType = filterValues.priority.rawValue
        } else {
            selectedFilterType = "Default"
        }
        
        delegate!.updateTable()
    }
}
