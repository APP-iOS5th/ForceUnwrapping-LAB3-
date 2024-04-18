//
//  ContentView.swift
//  Calculator
//
//  Created by 정종원 on 4/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var calculatorTextNumber = "0"
    @State private var currentOperand = ""
    @State private var calculateNumber1 = ""
    @State private var calculateNumber2 = ""
    
    private var displayNumber: String {
        return "\(calculateNumber1) \(currentOperand) \(calculatorTextNumber)"
    }
    
    let buttons = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        [".", "0", "C", "+"],
        ["="]
    ]
    
    var body: some View {
        VStack {
            
            Text(displayNumber)
                .font(.largeTitle)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .background(.gray)
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 15) {
                    ForEach(row, id: \.self) { button in
                        Button {
                            buttonTapped(button)
                        } label: {
                            if button == "=" {
                                Text(button)
                                    .frame(height: 100)
                                
                            } else {
                                Text(button)
                                    .frame( height: 100)
                            }
                        }
                        .font(.title)
                        .foregroundStyle(.black)
                        .padding()
                        .frame(maxWidth: .infinity)

                        .border(.gray, width: 1)
                        .background(.white)
                    }
                }
            }
            
        }
    }
    
    private func buttonTapped(_ button: String) {
        switch button {
        case "+", "-", "*", "/":
            calculate(operand: button)
        case "=":
            calculateResult()
        case "C":
            clear()
        default: //"."과 숫자입력
            if calculatorTextNumber == "0" || currentOperand == "=" {
                calculatorTextNumber = button
                currentOperand = ""
            } else {
                calculatorTextNumber += button
            }
        }
    }
    
    private func calculate(operand: String) {
        if !calculateNumber1.isEmpty && !calculateNumber2.isEmpty && !currentOperand.isEmpty {
            let num1 = Double(calculateNumber1) ?? 0
            let num2 = Double(calculateNumber2) ?? 0
            var result = 0.0
            
            switch currentOperand {
            case "+":
                result = num1 + num2
            case "-":
                result = num1 - num2
            case "*":
                result = num1 * num2
            case "/":
                if num2 != 0 {
                    result = num1 / num2
                } else {
                    calculatorTextNumber = "Error"
                    return
                }
            default:
                break
            }
            calculatorTextNumber = String(result)
            calculateNumber1 = ""
            calculateNumber2 = ""
            currentOperand = ""
        } else {
            currentOperand = operand
            calculateNumber1 = calculatorTextNumber
            calculatorTextNumber = ""
        }
    }
    
    private func calculateResult() {
        if !calculatorTextNumber.isEmpty && !currentOperand.isEmpty {
            calculateNumber2 = calculatorTextNumber
            calculate(operand: currentOperand)
        }
    }
    
    private func clear() {
        calculatorTextNumber = "0"
        calculateNumber1 = ""
        calculateNumber2 = ""
        currentOperand = ""
    }
    
}





#Preview {
    ContentView()
}
