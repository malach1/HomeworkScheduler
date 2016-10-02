//
//  HomeworkDetailsTableViewCell.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 1/11/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

class HomeworkDetailsTableViewCell: UITableViewCell {
    
    // MARK: OUTLETS
    
    @IBOutlet weak var assignmentDetail: UILabel!
    

    // MARK: FUNCTIONS
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
