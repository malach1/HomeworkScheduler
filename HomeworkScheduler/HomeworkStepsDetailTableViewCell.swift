//
//  HomeworkStepsDetailTableViewCell.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 2/8/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

class HomeworkStepsDetailTableViewCell: UITableViewCell {
    
    // MARK: OUTLETS
    
    @IBOutlet weak var completeVsAllStepsLbl: UILabel!
    @IBOutlet weak var stepsTitleLbl: UILabel!
    @IBOutlet weak var showSteps: UIButton!
    
    
    // MARK: FUNCTIONS

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
