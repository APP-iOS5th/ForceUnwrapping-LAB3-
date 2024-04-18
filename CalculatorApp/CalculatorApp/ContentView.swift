//
//  ContentView.swift
//  CalculatorApp
//
//  Created by wonyoul heo on 4/18/24.
//

import SwiftUI

struct ContentView: View {
    @State var inputNumber = ""
    @State var calculatedNumber = 0.0
    
    let buttonName = ["7", "8", "9", "/", "4", "5", "6", "*", "1","2","3","-",".","0","C","+"]
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    var body: some View {
        VStack {
            Text(inputNumber)
            LazyVGrid(columns: columns, spacing: 50) {
                ForEach(0..<16, id: \.self) { index in
                    Button(action: {
                        if buttonName[index] == "C"{
                            inputNumber = ""
                        } else {
                            inputNumber += buttonName[index]}
                    }) {
                        Text(buttonName[index])
                    }
                }
            }
            Button(action: {calculateResult()}) {
                Text("계산하기")
            }
            Text("= \(calculatedNumber)")
            
        }
    }
    
    func calculateResult() {
        let expression = NSExpression(format: inputNumber)
        if let result = expression.expressionValue(with: nil, context: nil) as? Double {
            calculatedNumber = result
        }
    }
}





#Preview {
    ContentView()
}
