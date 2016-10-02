//
//  AddHomeworkViewController.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 1/11/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import UIKit
import EventKit

var steps = [String]()

class AddHomeworkViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: PROPERTIES
    
    var segueID = "showAddSteps"
    var selectedClassroomValue = String()
    var classPickerData:[String] = ["Mandarin", "Math", "Humanities", "Science", "Writing"]
    var savedEventId:String = ""


    // MARK: OUTLETS
    
    @IBOutlet weak var assigmentTitle: UITextField!
    @IBOutlet weak var assignmentDueDate: UIDatePicker!
    @IBOutlet weak var assignmentPriority: UISegmentedControl!
    @IBOutlet weak var classPicker: UIPickerView!
    @IBOutlet weak var assignmentNotes: UITextView!
    @IBOutlet weak var addStepsBtn: UIButton!
    
    
    // MARK: ACTIONS
    
    @IBAction func saveBtn(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        let homeworkAssignment = Homework()
        homeworkAssignment.title = assigmentTitle.text!
        let dueDate:NSDate = assignmentDueDate.date
        homeworkAssignment.dateFormat = dueDate
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE',' MMM dd 'at' h:mm a"
        homeworkAssignment.date = "\(formatter.stringFromDate(dueDate))"
        
        if assignmentPriority.selectedSegmentIndex == 0 {
            homeworkAssignment.priority.0 = 3
            homeworkAssignment.priority.1 = "Low"
        } else if assignmentPriority.selectedSegmentIndex == 1 {
            homeworkAssignment.priority.0 = 2
            homeworkAssignment.priority.1 = "Medium"
        } else if assignmentPriority.selectedSegmentIndex == 2 {
            homeworkAssignment.priority.0 = 1
            homeworkAssignment.priority.1 = "High"
        }
        
        homeworkAssignment.details = assignmentNotes.text!
        homeworkAssignment.classSelect = selectedClassroomValue
        homeworkAssignment.steps = stepList
        homeworkList.append(homeworkAssignment)
        stepList.removeAll()
        
        let eventStore = EKEventStore()
        let calendarDueDate = assignmentDueDate.date
        var calendarTaskName = homeworkAssignment.title
        let endDate = calendarDueDate.dateByAddingTimeInterval(60 * 60)
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: { granted, error in
                self.createEvent(eventStore, title: calendarTaskName, startDate: calendarDueDate, endDate: endDate) })
        } else {
            createEvent(eventStore, title: calendarTaskName, startDate: calendarDueDate, endDate: endDate)
        }
        
        calendarTaskName = ""
        homeworkAssignment.didComplete = false
        homeworkAssignment.wasProductive = false
    }
    
    
    @IBAction func cancelBtn(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    

    @IBAction func addSteps(sender: AnyObject) {
        performSegueWithIdentifier(segueID, sender: self)
    }
    
    
    // MARK: FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assigmentTitle.becomeFirstResponder()
        assigmentTitle.delegate = self
        assignmentNotes.delegate = self
        navigationItem.title = "Add Homework"
        classPicker.delegate = self
        classPicker.dataSource = self
        selectedClassroomValue = "Mandarin"
        
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        assigmentTitle.resignFirstResponder()
        
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text=="\n"){
            assignmentNotes.resignFirstResponder()
            
            return false
        }
        
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        dispatch_async(dispatch_get_main_queue()) {
            textView.selectAll(nil)
        }
        
        UIView.animateWithDuration(0.27, delay: 0, options: .CurveLinear, animations: {
            self.view.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 2)-215)
        }, completion: {
            (finished: Bool) in
        })
    }
    

    
    func textViewDidEndEditing(textView: UITextView) {
        UIView.animateWithDuration(0.15, delay: 0, options: .CurveLinear, animations: {
            self.view.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 2))
            }, completion: {
                (finished: Bool) in
        })
    }
    
    func createEvent(eventStore:EKEventStore, title:String, startDate:NSDate, endDate:NSDate) {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Bad things happened.")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == segueID) {
            let vc = segue.destinationViewController as! StepsTableViewController
        }
    }
    
    
     // MARK: PICKER DELEGATES
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classPickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classPickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectedClassroomValue = classPickerData[row]
    }
}
