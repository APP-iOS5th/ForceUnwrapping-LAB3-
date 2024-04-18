//
//  ContentView.swift
//  CalculatorApp
//
//  Created by wonyoul heo on 4/18/24.
//

import SwiftUI

struct ContentView: View {
    @State var inputNumber = ""
    @State var calculatedNumber: Double?
    
    let buttonName = ["7", "8", "9", "/", "4", "5", "6", "*", "1","2","3","-",".","0","C","+"]
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    var body: some View {
        VStack(spacing: 40) {
            ZStack{
                Rectangle()
                    .frame(height: 100)
                    .opacity(0)
                    .border(Color.black, width: 3)
                    .overlay(Text(inputNumber).font(.largeTitle))
            }
            
            LazyVGrid(columns: columns, spacing: 50) {
                ForEach(0..<16, id: \.self) { index in
                    Button(action: {
                        if buttonName[index] == "C"{
                            inputNumber = ""
                            calculatedNumber = 0
                        } else if buttonName[index] == "."{
                            if inputNumber.last != "." {
                                inputNumber += buttonName[index]
                            }
                        }
                        
                        
                    
                        else {
                            inputNumber += buttonName[index]}
                    }) {
                        Text(buttonName[index])
                            .font(.system(size: 30))
                            .foregroundStyle(buttonName[index] == "C" ? Color.red : Color.blue)
                            .frame(width: 70, height: 50)
                            .border(Color.black, width: 2)
                            
                    }
                }
            }
            
            Button(action: {calculateResult()}) {
                Text("계산하기")
                    .font(.system(size: 30))
            }
            HStack{
                Text("  =")
                Spacer()
                Text("\(calculatedNumber ?? 0)")
                    
            }
            .font(.system(size: 40))
        }
    }
    
    func calculateResult() {
        
        let expression = NSExpression(format: inputNumber)
        // inputNumber에 계산할 수식이 있나?
        if let result = expression.expressionValue(with: nil, context: nil) as? Double {
            // if let : 수식의 결과가 유효한 Double 일 경우에만 result에 값을 반환한다.
            // as? : 계산 결과를 Double로 타입 캐스트 수행하며 실패할 경우 nil을 반환한다
            calculatedNumber = result
        }
    }
}

/*
 1. 나누기에 소수점이 안나온다
 2. ..1 값을 넣으면 에러가 발생한다.
 3. 아무것도 없을 때 계산하기 누르면 에러 남
 
 2번 에러는 해결했는데 에러 케이스를 만든 것은 아님
*/



#Preview {
    ContentView()
}
