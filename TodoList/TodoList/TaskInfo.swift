//
//  TaskInfo.swift
//  TodoList
//
//  Created by wonyoul heo on 4/25/24.
//

import Foundation

enum Priority: Comparable , CaseIterable{
    case high
    case medium
    case low
}

class Task: Identifiable {
    var id = UUID()
    var completed: Bool
    var description: String
    var priority: Priority
    
    init(id: UUID = UUID(), completed: Bool, description: String, priority: Priority) {
        self.id = id
        self.completed = completed
        self.description = description
        self.priority = priority
    }
}

extension Task {
    static var tasks = [
        Task(completed: false, description: "Wake up", priority: .low ),
        Task(completed: false, description: "Shower", priority: .medium),
        Task(completed: false, description: "Code", priority: .high),
        Task(completed: false, description: "Eat", priority: .high ),
        Task(completed: false, description: "Sleep", priority: .high),
        Task(completed: false, description: "Get groceries", priority: .high)
    ]
    static var task = tasks[0]
}

extension Task {
    func priorityToString() -> String {
        switch priority {
        case .high:
            return "High"
        case .medium:
            return "Medium"
        case .low:
            return "Low"
        }
    }
    
}
