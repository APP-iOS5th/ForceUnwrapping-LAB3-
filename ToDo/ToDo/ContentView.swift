//
//  ContentView.swift
//  ToDo
//
//  Created by seokyung on 4/25/24.
//

//우선순위가 높은 걸 위에 띄우기
//일단 동그라미 만들기
//달력화면을 넣고 해당 날짜가 동그라미로 차면 좋겠다

import SwiftUI

struct ContentView: View {
    @State private var tasks = Task.tasks
    @State private var newTaskDescription = ""
    @State private var newTaskPriority: Priority = .high
    @State private var isEditing = false
    @State private var isAddingTask = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($tasks) { $task in
                    HStack {
                        Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                task.completed.toggle()
                            }
                            .contentShape(Rectangle())
                        Text("\(task.description)")
                    }
                    .frame(height: 50)
                    .contextMenu {
                        Button("Edit") {
                            isEditing = true
                            newTaskDescription = task.description
                            newTaskPriority = task.priority
                        }
                        Button("Delete") {
                            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                tasks.remove(at: index)
                            }
                        }
                    }
                }
                .onDelete(perform: removeTodo)
            }
            .navigationTitle("To do list")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        isAddingTask.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditTaskView(isPresented: $isEditing, description: $newTaskDescription, priority: $newTaskPriority, editTask: editTask)
        }
        .sheet(isPresented: $isAddingTask) {
            AddTaskView(isPresented: $isAddingTask, description: $newTaskDescription, priority: $newTaskPriority, addTask: addTask)
        }
    }
    
    func removeTodo(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func addTask() {
        let newTask = Task(completed: false, description: newTaskDescription, priority: newTaskPriority)
        tasks.append(newTask)
        newTaskDescription = ""
        isAddingTask = false
        // print("\(tasks.count)")
    }
    
    func editTask() {
        guard let index = tasks.firstIndex(where: { $0.description == newTaskDescription }) else { return }
        tasks[index].priority = newTaskPriority
        isEditing = false
    }
}

struct EditTaskView: View {
    @Binding var isPresented: Bool
    @Binding var description: String
    @Binding var priority: Priority
    var editTask: () -> Void
    
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
                
                Button("Save") {
                    editTask()
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Edit Task")
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

#Preview {
    ContentView()
}
