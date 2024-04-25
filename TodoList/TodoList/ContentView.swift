//
//  ContentView.swift
//  TodoList
//
//  Created by wonyoul heo on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @State var showSheet: Bool = false
    @State var todos: [Task] = []
    @State var selectedPriority: Priority = .medium
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(todos) {todo in
                    VStack(alignment: .trailing){
                        HStack{
                            Button (action: {toggleCompletion(for: todo)},
                                    label: {Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                            })
                            .padding(.trailing, 10)
                            VStack(alignment: .leading){
                                Text(todo.priorityToString())
                                    .padding(.bottom, 2)
                                Text(todo.description)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive){
                                deleteTodo(todo)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(Text("TodoList"))
            .toolbar {
                ToolbarItem{
                    Button("추가") {
                        showSheet = true
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddTodoView(todos: $todos, showSheet: $showSheet)
                    .presentationDetents([.height(300)])
            }
        }
    }
    
    func deleteTodo(_ todo: Task) {
        if let index = todos.firstIndex(where: { $0.id == todo.id} ) {
            todos.remove(at: index)
        }
    }
    
    func toggleCompletion(for task: Task) {
        task.completed.toggle()
    }
}


struct AddTodoView: View {
    @Binding var todos : [Task]
    @Binding var showSheet: Bool
    @State var TodoText: String = ""
    @State var completed: Bool = false
    @State var selectedPriority: Priority = .medium
    
    var body: some View {
        VStack{
            HStack{
                Button("취소") {
                    showSheet = false
                }
                Spacer()
                Button("완료") {
                    addTodo(TodoText, priority: selectedPriority, completed: completed)
                    showSheet = false
                }
                .disabled(TodoText.isEmpty)
            }
            
            .padding()
            VStack{
                TextField("해야 할 일을 적으세요", text: $TodoText, axis:  .vertical)
                    .padding()
                    .foregroundStyle(Color.black)
                Spacer()
                HStack{
                    Text("우선순위: ")
                    Picker("Priority!", selection: $selectedPriority) {
                        Text("High").tag(Priority.high)
                        Text("Medium").tag(Priority.medium)
                        Text("Low").tag(Priority.low)
                        
                    }
                    .pickerStyle(.menu)
                }
            }
            
            
        }
        .padding()
    }
    func addTodo(_ text: String, priority: Priority, completed: Bool) {
        let todo = Task(completed: false, description: text, priority: priority)
        todos.append(todo)
    }
}

   




#Preview {
    ContentView()
}


/*
 selectedPriority 의 경우 굳이 하위뷰 값과 상호작용 할 필요가 없기 때문에
 State Binding 이 아닌 State 만 써도 된다.
 
 그리드뷰??
 
 id 가 있기 때문에 remove 할 때 id 일치 한 index 삭제
 
 struct bool 값은 왜 toggle 이 안되나
 
 
 */
