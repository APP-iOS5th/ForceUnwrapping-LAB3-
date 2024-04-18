//
//  ContentView.swift
//  Calculator
//
//  Created by 이서경 on 4/18/24.
//
// 음수 입력을 받도록 수정해야 함(완)
// .이 눌리면 자동으로 0.이 나오도록 수정하고 싶음(완)
// =을 눌러 결과값이 나온 상태 그대로 연산자를 눌러 다음 계산을 이어나가고 싶은데 동작하지 않음,,
// .2*3 만 0.600000000... 이렇게 값이 나오는 이유? 나머지 소수점은 잘 작동하는 것 같은데..

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
        case "+", "*", "/":
            if Double(currentInput) != nil {
                calculate()
                currentOperator = Character(button)
                storedValue = showNum
                currentInput = ""
            }
        case "-":
            if currentInput.isEmpty {
                currentInput = "-"
                showNum = currentInput
            }
        default:
            if button == "." {
                if currentInput.isEmpty {
                    currentInput = "0."
                    showNum = currentInput
                    return
                }
            } else if button == "." && currentInput.contains(".") {
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
        
        storedValue = showNum
        currentOperator = nil
    }
}

#Preview {
    ContentView()
}
