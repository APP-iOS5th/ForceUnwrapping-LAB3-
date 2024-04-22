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
    @Binding var memoText: String
    @Binding var memoColor: Color
    
    let colors: [Color]
    
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
                    let newMemo = Memo(text: memoText,colorHex: memoColor.hexString(), created: Date())
                    addMemo(newMemo)
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
    
    func addMemo(_ memo: Memo) {
        modelContext.insert(memo)
    }
}
