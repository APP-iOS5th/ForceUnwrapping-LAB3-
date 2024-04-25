//
//  AddTaskView.swift
//  ToDo
//
//  Created by seokyung on 4/25/24.
//

import Foundation
import SwiftUI

struct AddTaskView: View {
    @Binding var isPresented: Bool
    @Binding var description: String
    @Binding var priority: Priority
    var addTask: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter task", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Picker("Priority", selection: $priority) {
                    Text("High").tag(Priority.high)
                    Text("Medium").tag(Priority.medium)
                    Text("Low").tag(Priority.low)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button("Add") {
                    addTask()
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        isPresented.toggle()
                    }
                }
            }
        }
    }
}
