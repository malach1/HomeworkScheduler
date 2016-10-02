//
//  AddStepsViewController.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 2/4/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit


class AddStepsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: OUTLETS
    
    @IBOutlet weak var stepTitle: UITextField!

    
    // MARK: ACTIONS
    
    @IBAction func addStepsBtn(sender: AnyObject) {
        let step = (stepTitle.text!, false)
        stepList.append(step)
        print("adding step")
        navigationController?.popViewControllerAnimated(true)
    }

    
    // MARK: FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepTitle.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        stepTitle.resignFirstResponder()
        
        return true
    }
}
