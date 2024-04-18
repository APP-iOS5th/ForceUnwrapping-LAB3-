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
    var body: some View {
        VStack {
            Spacer()
            
            Text("90")
                .font(.system(size: 90))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            
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
                    CellOperatorContent(oper: "÷")
                    CellNumberContent(index: 0)
                    CellOperatorContent(oper: ".")
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
