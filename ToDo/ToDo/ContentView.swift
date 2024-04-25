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
import AVFoundation

struct ContentView: View {
    @State private var tasks = Task.tasks
    @State private var newTaskDescription = ""
    @State private var newTaskPriority: Priority = .high
    @State private var isEditing = false
    @State private var isAddingTask = false
    @State private var doneTask: Int = 0
    @State private var donePercent: Int = 0
    
    var body: some View {
        VStack {
            NavigationStack {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 30)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(donePercent) / 100)
                        .stroke(Color.blue, lineWidth: 30)
                        .rotationEffect(.degrees(-90))
                    
                    Text("\(donePercent)%")
                        .font(.system(size: 35, weight: .bold))
                }
                .padding()
                .frame(width:250)
                List {
                    ForEach($tasks) { $task in
                        HStack {
                            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    task.completed.toggle()
                                    updateProgress()
                                    print("\(doneTask)")
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
    }
    
    
    func removeTodo(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        updateProgress()
    }
    
    func addTask() {
        let newTask = Task(completed: false, description: newTaskDescription, priority: newTaskPriority)
        tasks.append(newTask)
        newTaskDescription = ""
        isAddingTask = false
        updateProgress()
        // print("\(tasks.count)")
    }
    
    func editTask() {
        guard let index = tasks.firstIndex(where: { $0.description == newTaskDescription }) else { return }
        tasks[index].priority = newTaskPriority
        isEditing = false
        updateProgress()
    }
    
    func updateProgress() {
        let doneTasks = tasks.filter { $0.completed }
        doneTask = doneTasks.count
        donePercent = Int((Double(doneTask) / Double(tasks.count)) * 100)
    }
}




#Preview {
    ContentView()
}
