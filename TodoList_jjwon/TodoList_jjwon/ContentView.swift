//
//  ContentView.swift
//  TodoList_jjwon
//
//  Created by 정종원 on 4/25/24.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var todos: [Todo]
    @Environment(\.modelContext) var modelContext
        
    @State private var showingAddSheet = false
    @State private var newTodoDescription = ""
    @State private var newTodoPriority: Priority = .medium
    
    
    var body: some View {
        NavigationStack {
            List {
                
                Section(header: Text("High Priority")) {
                    ForEach(todos.filter { $0.priority == .high }) { todo in
                        TaskRow(todo: todo)
                    }
                    .onDelete { indexSet in
                        let todo = todos[indexSet.first ?? 0]
                        modelContext.delete(todo)
                    }
                    .padding()
                }
                
                Section(header: Text("Medium Priority")) {
                    ForEach(todos.filter { $0.priority == .medium }) { todo in
                        TaskRow(todo: todo)
                    }
                    .onDelete { indexSet in
                    let todo = todos[indexSet.first ?? 0]
                    modelContext.delete(todo)
                }
                    .padding()
                }
                
                Section(header: Text("Low Priority")) {
                    ForEach(todos.filter { $0.priority == .low }) { todo in
                        TaskRow(todo: todo)
                    }
                    .onDelete { indexSet in
                        let todo = todos[indexSet.first ?? 0]
                        modelContext.delete(todo)
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
                AddTodoView(
                    newTodoDescription: $newTodoDescription,
                    newTodoPriority: $newTodoPriority,
                    showingAddSheet: $showingAddSheet,
                    addTodoItem: addTodoItem)
                .presentationDetents([.medium])
            }
            
        }//NavigationStack
    }
    private func addTodoItem(todoDescription: String, priority: Priority) {
        let newTodo = Todo(completed: false, todoDescription: todoDescription, priority: priority)
        modelContext.insert(newTodo)
    }
}

struct TaskRow: View {
    var todo: Todo
    
    var body: some View {
        HStack {
            Button {
                todo.completed.toggle()
            } label: {
                Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
            }
            Text(todo.todoDescription)
            Spacer()
        }
    }
}

struct AddTodoView: View {
    @Binding var newTodoDescription: String
    @Binding var newTodoPriority: Priority
    @Binding var showingAddSheet: Bool
    let addTodoItem: (String, Priority) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("할일을 적어주세요.", text: $newTodoDescription)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            Picker("Priority", selection: $newTodoPriority) {
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
                    addTodoItem(newTodoDescription, newTodoPriority)
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
