//
//  AssignmentTableViewCell.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 1/11/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {
    
    // MARK: OUTLETS
    
    @IBOutlet weak var assignmentTitleLabel: UILabel!
    @IBOutlet weak var assignmentDueDateLabel: UILabel!
    @IBOutlet weak var assignmentClassLabel: UILabel!
    @IBOutlet weak var assignmentPriorityLabel: UILabel!
    
    
    // MARK: FUNCTIONS
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
