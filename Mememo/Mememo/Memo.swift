//
//  Memo.swift
//  Mememo
//
//  Created by seokyung on 4/23/24.
//


import SwiftUI
import SwiftData

@Model
class Memo {
    var id: UUID
    var text: String
    var stringColor: String
    var created: Date
    
    var createdString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: created)
        }
    }
    
    var color: Color {
        Color(hex: stringColor)
    }
    
    init(id: UUID = UUID(), text: String, stringColor: String, created: Date = Date()) {
        self.id = id
        self.text = text
        self.stringColor = stringColor
        self.created = created
    }
}


// Color 확장을 추가하여 16진수 문자열에서 Color 인스턴스를 생성하는 이니셜라이저 추가
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
