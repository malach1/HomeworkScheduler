//
//  Homework.swift
//  HomeworkScheduler
//
//  Created by Merritt Vassallo on 1/28/16.
//  Copyright © 2016 Merritt Vassallo. All rights reserved.
//

import Foundation

class Homework {
    var title = String()
    var date = String()
    var dateFormat = NSDate()
    var details = String()
    var priority = (Int(), String())
    var steps = [(String, Bool)]()
    var classSelect = String()
    var didComplete = Bool()
    var wasProductive = Bool()
    var homeworkIndex = Int()
}