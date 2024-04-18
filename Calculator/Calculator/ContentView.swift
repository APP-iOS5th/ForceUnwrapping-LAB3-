import SwiftUI

struct ContentView: View {
    // 계산기 버튼 목록
    //@State var cChange: Bool = false
    //@State var cAndAC = "AC"
    @State var buttons = [
        ["AC", "+/-", "%", "/"],
        ["7", "8", "9", "X"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
//    init() {
//        buttons[0][0] = "AC"
//    }
    // 현재 화면에 표시될 값
    @State var display = "0"
    // 첫 번째 피연산자
    @State var operand1 = ""
    // 두 번째 피연산자
    @State var operand2 = ""
    // 현재 선택된 연산자
    @State var operation = ""
    // 화면 초기화 여부
    @State var clearDisplay = true
    
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
                .frame(maxHeight: .infinity)
            Text(display)
                .foregroundColor(.white)
                .font(.system(size: 60))
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
                .padding(.trailing, 20)
            
            // 계산기 버튼 그리드
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 5) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            // 버튼 클릭 핸들러
                            handleButtonPress(button)
                        }, label: {
                            if button != "0"{
                                
                                Text(button)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .frame(width: 80, height: 80)
                                    .background(buttonBackground(button))
                                    .foregroundColor(.white)
                                    .cornerRadius(60)
                                
                            }else{
                                
                                
                                
                                Text(button)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .frame(width: 160, height: 80)
                                    .background(buttonBackground(button))
                                    .foregroundColor(.white)
                                    .cornerRadius(60)
                                
                            }
                        })
                    }
                }
            }
            
            
        } //:VSTACK
        .padding(15)
        .background(Color.black)
        .onChange(of: display){ new, index in
            if index != "0" {
                buttons[0][0] = "C"
            }else{
                buttons[0][0] = "AC"
            }
            
        }
        
    }
    
    
    
    // 버튼 배경 색상
    func buttonBackground(_ button: String) -> Color {
        switch button {
        case "X", "-", "+", "=", "/":
            return Color.orange
        case "C", "+/-", "%", "AC":
            return Color.gray
        default:
            return Color.secondary
        }
    }
    
    // 계산기 버튼 클릭 핸들러
    func handleButtonPress(_ button: String) {
        switch button {
        case "C", "AC":
            // "C" 버튼: 화면 초기화
            display = "0"
            operand1 = ""
            operand2 = ""
            operation = ""
            clearDisplay = true
        case "X", "-", "+","/":
            // 연산자 버튼: 피연산자 설정
            operation = button
            if operand1 != "" {
                operand2 = display
                display = calculate(x: operand1, y: display)
                operand1 = display
                
            }else{
                operand1 = display
            }
            clearDisplay = true
        case "=":
            // "=" 버튼: 계산 수행
            operand2 = display
            let result = calculate(x: operand1, y: operand2)
            display = result
            operand1 = operand2
            operand2 = result
            //operation = ""
            clearDisplay = true
        case "0":
            if display != "0"{
                display += button
            }
        case ".":
            if !display.contains("."){
                display += "."
            }
            clearDisplay = false
        default:
            // 숫자나 "." 버튼: 현재 값에 추가
            if clearDisplay {
                display = button
                clearDisplay = false
            } else {
                display += button
            }
        }
    }
    
    // 계산 함수
    func calculate(x: String, y: String) -> String {
        // 피연산자와 연산자 추출
        // 올바른 숫자 형식으로 변환하여 계산 수행
        if let num1 = Double(x), let num2 = Double(y) {
            switch operation {
            case "X":
                return String(num1 * num2)
            case "-":
                return String(num1 - num2)
            case "+":
                return String(num1 + num2)
            case "/":
                return String(num1 / num2)
            default:
                return "0"
            }
        } else {
            // 올바른 숫자 형식이 아닌 경우 "0"으로 처리
            return "0"
        }
    }
    
    
}



#Preview {
    ContentView()
}
