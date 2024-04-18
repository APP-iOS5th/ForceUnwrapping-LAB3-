//
//  ContentView.swift
//  Calculator
//
//  Created by 이서경 on 4/18/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showNum = "0"
    @State private var currentInput = ""
    @State private var storedValue = ""
    @State private var currentOperator: Character? = nil

    let buttons: [[String]] = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        [".", "0", "C", "+"],
        ["="]
    ]

    var body: some View {
        VStack(spacing: 12) {
            Text(showNum)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)

            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .foregroundColor(button == "C" ? .red : .black)
                                .border(.gray)
                        }
                    }
                }
            }
        }
        .padding()
    }

    func buttonTapped(_ button: String) {
        switch button {
        case "C":
            clear()
        case "=":
            calculate()
            currentInput = ""
            storedValue = ""
            currentOperator = nil
        case "+", "-", "*", "/":
            if Double(currentInput) != nil {
                if currentOperator != nil {
                    calculate()
                }
                currentOperator = Character(button)
                storedValue = currentInput
                currentInput = ""
            }
        default:
            if button == "." && currentInput.contains(".") {
                return
            }
            currentInput += button
            showNum = currentInput
        }
    }

    func clear() {
        showNum = "0"
        currentInput = ""
        storedValue = ""
        currentOperator = nil
    }

    func calculate() {
        guard let tappedOperator = currentOperator,
              let storedNum = Double(storedValue),
              let inputNum = Double(currentInput) else {
            return
        }

        var result: Double = 0.0
        switch tappedOperator {
        case "+":
            result = storedNum + inputNum
        case "-":
            result = storedNum - inputNum
        case "*":
            result = storedNum * inputNum
        case "/":
            if inputNum != 0 {
                result = storedNum / inputNum
            } else {
                showNum = "오류"
                return
            }
        default:
            break
        }

        if result == floor(result) {
            showNum = "\(Int(result))"
        } else {
            showNum = "\(result)"
        }

        currentInput = showNum
        storedValue = ""
        currentOperator = nil
    }
}

#Preview {
    ContentView()
}
