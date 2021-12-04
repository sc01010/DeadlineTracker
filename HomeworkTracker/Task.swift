//
//  Task.swift
//  HomeworkTracker
//
//  Created by Steven Chen on 11/21/21.
//

import Foundation
import UIKit

struct TaskResponse: Codable {
    var success: Bool
    var data: Task
}

struct TasksResponse: Codable {
    var success: Bool
    var data: [Task]
}

struct Task: Codable {
    var id: Int
    var task_name: String
    var subject: String
    var due_date: String
    
//    init(task_name: String, subject: String, due_date: String) {
//        self.task_name = task_name
//        self.subject = subject
//        self.due_date = due_date
//    }
}
