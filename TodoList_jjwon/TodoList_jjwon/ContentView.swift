//
//  ContentView.swift
//  TodoList_jjwon
//
//  Created by 정종원 on 4/25/24.
//


import SwiftUI

struct ContentView: View {
    
    @State var tasks = Task.tasks.sorted(by: { $0.priority < $1.priority })
    @State private var showingAddSheet = false
    @State private var newTaskDescription = ""
    @State private var newTaskPriority: Priority = .medium
    
    
    var body: some View {
        NavigationStack {
            List {
                
                Section(header: Text("High Priority")) {
                    ForEach($tasks.filter { $0.priority.wrappedValue == .high }) { task in
                        TaskRow(task: task)
                    }
                    .onDelete { indexSet in
                        tasks.remove(atOffsets: indexSet)
                    }
                    .padding()
                }
                
                Section(header: Text("Medium Priority")) {
                    ForEach($tasks.filter { $0.priority.wrappedValue == .medium }) { task in
                        TaskRow(task: task)
                    }
                    .onDelete { indexSet in
                        tasks.remove(atOffsets: indexSet)
                    }
                    .padding()
                }
                
                Section(header: Text("Low Priority")) {
                    ForEach($tasks.filter { $0.priority.wrappedValue == .low }) { task in
                        TaskRow(task: task)
                    }
                    .onDelete { indexSet in
                        tasks.remove(atOffsets: indexSet)
                    }
                    .padding()
                }
                
            }//List
            .navigationBarTitle("To do List")
            .font(.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddTaskView(
                    newTaskDescription: $newTaskDescription,
                    newTaskPriority: $newTaskPriority,
                    showingAddSheet: $showingAddSheet,
                    addTodoItem: addTodoItem)
                .presentationDetents([.medium])
            }
            
        }//NavigationStack
    }
    private func addTodoItem(description: String, priority: Priority) {
        let newTask = Task(completed: false, description: description, priority: priority)
        tasks.append(newTask)
    }
}

struct TaskRow: View {
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Button {
                task.completed.toggle()
            } label: {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
            }
            Text(task.description)
            Spacer()
        }
    }
}

struct AddTaskView: View {
    @Binding var newTaskDescription: String
    @Binding var newTaskPriority: Priority
    @Binding var showingAddSheet: Bool
    let addTodoItem: (String, Priority) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("할일을 적어주세요.", text: $newTaskDescription)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            Picker("Priority", selection: $newTaskPriority) {
                ForEach(Priority.allCases, id: \.self) { priority in
                    Text(String(describing: priority))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            HStack(spacing: 20) {
                Button(action: {
                    showingAddSheet = false
                }) {
                    Text("취소")
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    addTodoItem(newTaskDescription, newTaskPriority)
                    showingAddSheet = false
                }) {
                    Text("할일 추가")
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            } // HStack
            .padding(.horizontal)
        } // VStack
        .padding()
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding()
    }
}

#Preview {
    ContentView()
}
