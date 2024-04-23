//
//  ContentView.swift
//  Mememo
//
//  Created by wonyoul heo on 4/22/24.
//
import Foundation
import SwiftUI
import SwiftData



struct ContentView: View {
    @State var showSheet = false
    @Environment(\.modelContext) var modelContext
    @Query var memos: [Memo]
    
    var body: some View {
        NavigationStack{
            List(memos) { memo in
                HStack{
                    VStack(alignment: .leading){
                        Text("\(memo.text)")
                            .font(.title)
                        
                        Text("\(memo.createdString)")
                            .font(.body)
                            .padding(.top)
                        Spacer()
                    }
                }
                .padding()
                .foregroundColor(.white)
//                .background(memo.color)
                .shadow(radius: 3)
                .padding()
                .contextMenu{
                    ShareLink(item: memo.text)
                    Button {
                        modelContext.delete(memo)
                    } label: {
                        Image(systemName: "trash")
                        Text("삭제")
                    }
                }
                Spacer()
                
            }
            .listStyle(.plain)
            .navigationTitle("mememo")
            .toolbar {
                ToolbarItem{
                    Button("추가") {
                        showSheet = true
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                MemoAddView(showSheet: $showSheet)
            }
        }
        
    }

}


struct MemoAddView: View {
    @Environment(\.modelContext) var modelContext
    
    @Binding var showSheet: Bool
    @State var memoText: String = ""
    @State var memoColor: Color = .blue
    
    let colors : [Color] = [.blue, .cyan, .purple, .yellow, .indigo]
    
    var body: some View {
        VStack{
            HStack{
                Button("취소") {
                    showSheet = false
                }
                Spacer()
                Button("완료") {
                    addMemo(memoText)
                    showSheet = false
                }
                .disabled(memoText.isEmpty)
            }
            .padding()
            HStack{
                
                ForEach(colors, id: \.self) { color in
                    Button {
                        memoColor = color
                    } label: {
                        HStack {
                            Spacer()
                            if color == memoColor {
                                Image(systemName: "checkmark.circle.fill")
                            }
                            Spacer()
                        }
                        .frame(height: 50)
                        .background(color)
                        .foregroundColor(.white)
                        .shadow(radius: color == memoColor ? 8 : 0)
                    }
                }
            }
            .padding()
            
            Divider()
                .padding()
            
            VStack{
                TextField("메모를 입력하세요", text: $memoText, axis: .vertical)
                    .padding()
                    .foregroundStyle(.white)
                    .background(memoColor)
                    .shadow(radius: 3)
            }
            .padding()
            
            Spacer()
        }
    }
    
    func addMemo(_ text: String/*,color: Color*/) {
            let memo = Memo(text: text/*, color: Color, created: Date()*/)
            modelContext.insert(memo)
        }
}





#Preview {
    ContentView()
        .modelContainer(for: Memo.self)
}
