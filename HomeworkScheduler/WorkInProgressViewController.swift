//
//  WorkInProgressViewController.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 1/11/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit

class WorkInProgressViewController: UIViewController {
    
    // MARK: PROPERTIES
    
    var SwiftTimer = NSTimer()
    var SwiftCounter = 0
    var secondsToCountDown = Int()
    var passedHomeworkModel = Homework()
    var segueID = "toCheckIn"
    
    
    // MARK: OUTLETS
    
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var startCountDownBtn: UIButton!
    @IBOutlet weak var timeProgress: UIProgressView!
    
    
    // MARK: ACTIONS

    @IBAction func startCountDownBtnPressed(sender: AnyObject) {
        SwiftTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        startCountDownBtn.enabled = false
    }
    
    @IBAction func stopCountDownBtnPressed(sender: AnyObject) {
        SwiftTimer.invalidate()
        startCountDownBtn.enabled = true
    }
    
    @IBAction func resetCountDownBtnPressed(sender: AnyObject) {
        stopCountDownBtnPressed(self)
        SwiftCounter = 0
        resetValue()
    }
    
    @IBAction func doneBtnPressed(sender: AnyObject) {
        SwiftTimer.invalidate()
        startCountDownBtn.enabled = true

        performSegueWithIdentifier(segueID, sender: self)
    }
    
    
    // MARK: FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetValue()
        startCountDownBtnPressed(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        if OKbutton == true {
            navigationController?.popViewControllerAnimated(true)
        }
    }
  
    func updateCounter() {
        let timeLeft = secondsToCountDown - SwiftCounter++
        let(h,m,s) = convertSeconds(timeLeft)
        
        if h == 0 || h == 1 || h == 2 || h == 3 || h == 4 || h == 5 || h == 6 || h == 7 || h == 8 || h == 9 {
            hourLabel.text = "0\(h)"
        } else {
            hourLabel.text = "\(h)"
        }
        
        if m == 0 || m == 1 || m == 2 || m == 3 || m == 4 || m == 5 || m == 6 || m == 7 || m == 8 || m == 9 {
            minuteLabel.text = "0\(m)"
        } else {
            minuteLabel.text = "\(m)"
        }
        
        if s == 0 || s == 1 || s == 2 || s == 3 || s == 4 || s == 5 || s == 6 || s == 7 || s == 8 || s == 9 {
            secondLabel.text = "0\(s)"
        } else {
            secondLabel.text = "\(s)"
        }

        if (hourLabel.text == "00") && (minuteLabel.text == "00") && (secondLabel.text == "00") {
            timerAtZero("You have completed a work session!", message:"You have run out of time!", buttonMessage:"Ok")
            stopCountDownBtnPressed(self)
        }
        
        setProgress()
    }
    
    func timerAtZero(title:String, message:String, buttonMessage:String) {
        let actionSheetController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        let workComplete:UIAlertAction = UIAlertAction(title: buttonMessage, style: .Default) { action -> Void in }
        actionSheetController.addAction(workComplete)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func convertSeconds(seconds:Int) -> (Int, Int, Int){
        return (seconds/3600, (seconds%3600)/60, (seconds%3600)%60)
    }
    
    func resetValue() {
        let(h,m,s) = convertSeconds(secondsToCountDown)
        if h == 0 || h == 1 || h == 2 || h == 3 || h == 4 || h == 5 || h == 6 || h == 7 || h == 8 || h == 9 {
            hourLabel.text = "0\(h)"
        } else {
            hourLabel.text = "\(h)"
        }
        
        if m == 0 || m == 1 || m == 2 || m == 3 || m == 4 || m == 5 || m == 6 || m == 7 || m == 8 || m == 9 {
            minuteLabel.text = "0\(m)"
        } else {
            minuteLabel.text = "\(m)"
        }
        
        if s == 0 || s == 1 || s == 2 || s == 3 || s == 4 || s == 5 || s == 6 || s == 7 || s == 8 || s == 9 {
            secondLabel.text = "0\(s)"
        } else {
            secondLabel.text = "\(s)"
        }
    }
    
    func setProgress(){
        var timer:Float = 0
        timer = Float(SwiftCounter-1)/Float(secondsToCountDown)
        timeProgress.progress = timer
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueID {
            let vc = segue.destinationViewController as! CheckInViewController
            vc.passedHomeworkIndex = passedHomeworkModel.homeworkIndex
        }
    }
}
