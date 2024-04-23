//
//  MemoAddView.swift
//  MemoWithSwiftData
//
//  Created by 정종원 on 4/22/24.
//

import SwiftUI

struct MemoAddView: View {
    
    @Environment(\.modelContext) var modelContext
    @Binding var isSheetShowing: Bool
    @State var memoText: String = ""
    @State var memoColor: Color = .blue
    
    let colors: [Color] = [.blue, .cyan, .purple, .yellow, .indigo]

    
    var body: some View {
        VStack {
            HStack {
                Button{
                    isSheetShowing = false
                } label: {
                    Text("Cancle")
                }
                Spacer()
                Button {
                    addMemo(memoText, color: memoColor)
                    isSheetShowing = false
                } label: {
                    Text("Complete")
                }
                .disabled(memoText.isEmpty)
            }//HStack
            
            HStack {
                ForEach(colors, id: \.self) { color in
                    Button {
                        memoColor = color
                    } label: {
                        HStack {
                            Spacer()
                            if color == memoColor {
                                Image(systemName: "checkmark.circle")
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .foregroundStyle(.white)
                        .background(color)
                        .shadow(radius: color == memoColor ? 8 : 0 )
                    }//Button
                }//ForEach
            }//HStack
            Divider()
                .padding()
            TextField("메모를 입력하세요", text: $memoText, axis: .vertical)
                .padding()
                .foregroundStyle(.white)
                .background(memoColor)
                .shadow(radius: 3)
            Spacer()
        }//VStack
        .padding()
    }
    
    func addMemo(_ text: String, color: Color) {
        let memo = Memo(text: text, color: color, created: Date())
        modelContext.insert(memo)
    }
}
