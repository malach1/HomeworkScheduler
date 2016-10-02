//
//  CheckInViewController.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 3/8/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

var OKbutton = false

class CheckInViewController: UIViewController {
    
    // MARK: PROPERTIES
    
    var passedHomeworkIndex = Int()
    var segueID = "backToList"
    
    
    // MARK: OUTLETS
    
    @IBOutlet weak var productiveQstLbl: UILabel!
    @IBOutlet weak var wsntP: UIButton!
    @IBOutlet weak var wasP: UIButton!
    @IBOutlet weak var F: UIButton!
    @IBOutlet weak var ddntF: UIButton!
    @IBOutlet weak var fnstcStmLbl: UILabel!
    @IBOutlet weak var OkBtn: UIButton!

    // MARK: ACTIONS
    
    @IBAction func didNotFinish(sender: AnyObject) {
        globalDidComplete.0 = passedHomeworkIndex
        globalDidComplete.1 = false
        globalTrigger = true
        productiveQstLbl.text = "Were you productive?"
        wsntP.setTitle("NO", forState: .Normal)
        wasP.setTitle("YES", forState: .Normal)
        F.enabled = false
    }
    
    @IBAction func finished(sender: AnyObject) {
        globalDidComplete.0 = passedHomeworkIndex
        globalDidComplete.1 = true
        globalTrigger = true
        productiveQstLbl.text = "Great Job! Did you feel productive?"
        wsntP.setTitle("NO", forState: .Normal)
        wasP.setTitle("YES", forState: .Normal)
        ddntF.enabled = false
        
    }
    
    @IBAction func wasNotProductive(sender: AnyObject) {
        globalWasProductive.0 = passedHomeworkIndex
        globalWasProductive.1 = false
        globalTrigger = true
        fnstcStmLbl.text = "Try to do better next time."
        OkBtn.setTitle("OK", forState: .Normal)
        wasP.enabled = false
    }
    
    @IBAction func wasProductive(sender: AnyObject) {
        globalWasProductive.0 = passedHomeworkIndex
        globalWasProductive.1 = true
        globalTrigger = true
        fnstcStmLbl.text = "Fantastic!"
        OkBtn.setTitle("OK", forState: .Normal)
        wsntP.enabled = false
    }
    
    
    override func viewDidLoad() {
        productiveQstLbl.text = ""
        wsntP.setTitle("", forState: .Normal)
        wasP.setTitle("", forState: .Normal)
        fnstcStmLbl.text = ""
        OkBtn.setTitle("", forState: .Normal)
    }

    @IBAction func okbuttonPressed(sender: AnyObject) {
        
        OKbutton = true
        navigationController?.popViewControllerAnimated(true)
    }

}
