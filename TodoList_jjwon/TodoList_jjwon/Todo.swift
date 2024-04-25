//
//  Todo.swift
//  TodoList_jjwon
//
//  Created by 정종원 on 4/25/24.
//

import Foundation
import SwiftData


enum Priority: Comparable, CaseIterable, Codable {
    case high
    case medium
    case low 
}

@Model
class Todo: Identifiable {
    var id = UUID()
    var completed: Bool
    var todoDescription: String
    var priority: Priority
    
    init(completed: Bool, todoDescription: String, priority: Priority) {
        self.completed = completed
        self.todoDescription = todoDescription
        self.priority = priority
    }
}

//extension Task {
//    static var tasks = [
//        Task(completed: false, description: "Wake up", priority: .low ),
//        Task(completed: false, description: "Shower", priority: .medium),
//        Task(completed: false, description: "Code", priority: .high),
//        Task(completed: false, description: "Eat", priority: .high ),
//        Task(completed: false, description: "Sleep", priority: .high),
//        Task(completed: false, description: "Get groceries", priority: .high)
//    ]
//    static var task = tasks[0]
//}
