//
//  ContentView.swift
//  Mememo
//
//  Created by seokyung on 4/22/24.
//


import SwiftUI
import SwiftData


struct ContentView: View {
    @Query var memos: [Memo]
    @Environment(\.modelContext) var modelContext
    @State var isSheetShowing: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memos) { memo in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(memo.text)")
                                .font(.title)
                                .foregroundStyle(.black)
                            Text("\(memo.createdString)")
                                .font(.body)
                                .padding(.top)
                                .foregroundStyle(.black)
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(memo.color)
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
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("mememo")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSheetShowing = true
                    } label : {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isSheetShowing) {
                MemoAddView(/*colors: colors,*/ isSheetShowing: $isSheetShowing)
            }
        }
    }
    
    func removeMemo(_ memo: Memo) {
        modelContext.delete(memo)
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Memo.self)
}
