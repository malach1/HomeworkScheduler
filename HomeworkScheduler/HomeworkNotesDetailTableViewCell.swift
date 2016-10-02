//
//  HomeworkNotesDetailTableViewCell.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 2/8/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

class HomeworkNotesDetailTableViewCell: UITableViewCell {
    
    // MARK: OUTLETS

    @IBOutlet weak var notes: UITextView!
    
    
    
    @IBOutlet weak var notesLbl: UILabel!
    
    
    // MARK: FUNCTIONS

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
