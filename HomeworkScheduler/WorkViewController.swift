//
//  WorkViewController.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 1/11/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

class WorkViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: PROPERTIES
    
    var secondsConverted = Int()
    var passedHomeworkModel = Homework()
    var addedHour = 0
    var addedMinute = 0
    var segueID = "showWorkInProgress"

    
    // MARK: OUTLETS
    
    @IBOutlet weak var timerHourValue: UITextField!
    @IBOutlet weak var timerMinuteValue: UITextField!
    @IBOutlet weak var completionTimeLbl: UILabel!
    
    @IBOutlet weak var strtWrk: UIButton!

    
    // MARK: ACTIONS
    
    @IBAction func workButtonPressed(sender: AnyObject) {
        var hour:Int = Int()
        var minute:Int = Int()
        
        if ((timerHourValue.text?.isEmpty) == true){
            hour = 0
        } else {
            hour = Int(timerHourValue.text!)!
        }
        
        if ((timerMinuteValue.text?.isEmpty) == true){
            minute = 0
        } else {
            minute = Int(timerMinuteValue.text!)!
        }
        
        secondsConverted = convertToSeconds(hour, minute: minute)
        performSegueWithIdentifier(segueID, sender: self)
    }
    
    
        
    // MARK: FUNCTIONS
    
    func textFieldDidBeginEditing(textField: UITextField) {
        timerFutureValue()
        viewWillAppear(true)
        reloadInputViews()

    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        timerFutureValue()
        viewWillAppear(true)
        reloadInputViews()
    }
    
    func timerFutureValue() {
        if ((timerHourValue.text?.isEmpty)==true) {
            addedHour = 0
        } else {
            addedHour = Int(timerHourValue.text!)!
        }
        
        if ((timerMinuteValue.text?.isEmpty)==true) {
            addedMinute = 0
        } else {
            addedMinute = Int(timerMinuteValue.text!)!
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([ .Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        let minute = components.minute
        var adjustHour = Int()
        var adjustMinute = Int()
        
        if ((timerHourValue.text?.isEmpty) == true) {
            adjustHour = hour+0
        } else {
            adjustHour = addedHour + hour
        }
        
        if ((timerMinuteValue.text?.isEmpty) == true) {
            adjustMinute = minute + 0
        } else {
            adjustMinute = addedMinute + minute
        }
 
        if adjustMinute >= 60 {
            let remainderMinutes = adjustMinute%60
            adjustMinute = remainderMinutes
            adjustHour++
        }
        
        if adjustHour > 12 {
            var remainderHours = adjustHour%12
            
            if remainderHours == 0 {
                remainderHours = 12
            }
            
            adjustHour=remainderHours
        }
        
        if (adjustMinute == 0) || (adjustMinute == 1) || (adjustMinute == 2) || (adjustMinute == 3) || (adjustMinute == 4) || (adjustMinute == 5) || (adjustMinute == 6) || (adjustMinute == 7) || (adjustMinute == 8) || (adjustMinute == 9) {
            completionTimeLbl.text = "\(adjustHour):0\(adjustMinute)"
        } else {
            completionTimeLbl.text = "\(adjustHour):\(adjustMinute)"
        }
        
        if ((timerHourValue.text?.isEmpty == true) || timerHourValue.text == "0") && ((timerMinuteValue.text?.isEmpty==true) || timerMinuteValue.text == "0") {
            strtWrk.enabled = false
        } else {
            strtWrk.enabled = true
        }
        
        
        if OKbutton == true {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    @IBAction func cnclBtn(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        timerHourValue.resignFirstResponder()
        timerMinuteValue.resignFirstResponder()

        return true
    }
    
    func convertToSeconds(hour:Int, minute:Int) -> Int {
        return hour*60*60 + minute*60
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == segueID) {
            let vc = segue.destinationViewController as! WorkInProgressViewController
            print("seconds passed over \(secondsConverted)")
            vc.secondsToCountDown = secondsConverted
            vc.passedHomeworkModel = passedHomeworkModel
        }
    }
}
