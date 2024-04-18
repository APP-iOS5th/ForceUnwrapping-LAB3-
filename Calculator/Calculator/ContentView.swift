//
//  ContentView.swift
//  Calculator
//
//  Created by uunwon on 4/18/24.
//

import SwiftUI

struct CellNumberContent: View {
    var index: Int
    
    var body: some View {
        Button(action: {
            print("\(index) clicked")
        }) {
            Text("\(index)")
                .frame(minWidth: 50, maxWidth: .infinity, minHeight: 100)
                .font(.system(.largeTitle))
                .foregroundColor(.white)
                .background(Circle().fill(Color.customGray))
        }
    }
}

struct CellOperatorContent: View {
    var oper: String
    
    var body: some View {
        Button(action: {
            print("\(oper) clicked")
        }) {
            Text(oper)
                .frame(minWidth: 50, maxWidth: .infinity, minHeight: 100)
                .font(.system(.largeTitle))
                .foregroundColor(.white)
                .background(Circle().fill(Color.orange))
        }
    }
}

struct ContentView: View {
    @State private var formula = ""
    var body: some View {
        VStack {
            Spacer()
            
            TextField("00", text: $formula)
                .font(.system(size: 80))
                .multilineTextAlignment(.trailing)
                .padding()
                // .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            
            Grid {
                GridRow {
                    ForEach(7...9, id: \.self) { index in
                        CellNumberContent(index: index)
                    }
                    CellOperatorContent(oper: "x")
                }
                GridRow {
                    ForEach(4...6, id: \.self) { index in
                        CellNumberContent(index: index)
                    }
                    CellOperatorContent(oper: "-")
                }
                GridRow {
                    ForEach(1...3, id: \.self) { index in
                        CellNumberContent(index: index)
                    }
                    CellOperatorContent(oper: "+")
                }
                GridRow {
                    CellOperatorContent(oper: formula.isEmpty ? "AC" : "C")
                    CellNumberContent(index: 0)
                    CellOperatorContent(oper: "÷")
                    CellOperatorContent(oper: "=")
                }
                
            }
            .padding(10)
        }
        .padding(.bottom)
    }
}

#Preview {
    ContentView()
}
