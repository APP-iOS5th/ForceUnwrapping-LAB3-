//
//  ContentView.swift
//  MemoWithSwiftData
//
//  Created by 정종원 on 4/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var memos: [Memo]
    @Environment(\.modelContext) var modelContext
    @State var isSheetShowing: Bool = false
    @State var memoText: String = ""
    @State var memoColor: Color = .blue

    let colors: [Color] = [.blue, .cyan, .purple, .yellow, .indigo]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memos) { memo in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(memo.text)")
                                .font(.title)
                            Text("\(memo.createdString)")
                                .font(.body)
                                .padding(.top)
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(.purple)
                    .shadow(radius: 3)
                    .padding()
                    .contextMenu {
                        ShareLink(item: memo.text)
                        Button {
                            removeMemo(memo)
                        } label:  {
                            Image(systemName: "trash.slash")
                            Text("삭제")
                        }
                        
                    }//contextMenu
                }//ForEach
            }//List
            .listStyle(.plain)
            .navigationTitle("MeMeMo")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSheetShowing = true
                    } label : {
                        Image(systemName: "plus")
                    }
                }
            }//toolbar
            .sheet(isPresented: $isSheetShowing) {
                MemoAddView(colors: colors, isSheetShowing: $isSheetShowing, memoText: $memoText, memoColor: $memoColor)
            }//sheet
        }//NavigationStack
    }
    
    func removeMemo(_ memo: Memo) {
        modelContext.delete(memo)
    }

}
