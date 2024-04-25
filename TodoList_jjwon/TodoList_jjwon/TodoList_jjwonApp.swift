//
//  TodoList_jjwonApp.swift
//  TodoList_jjwon
//
//  Created by 정종원 on 4/25/24.
//

import SwiftUI
import SwiftData

@main
struct TodoList_jjwonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Todo.self)
        }
        
    }
}
