//
//  Memo.swift
//  MemoWithSwiftData
//
//  Created by 정종원 on 4/22/24.
//

import SwiftUI
import SwiftData

@Model
class Memo: Identifiable {
    var id: UUID = UUID()
    var text: String
    var colorHex: String
    var created: Date
    
    var color: Color {
        Color(hex: colorHex)
    }
    
    init(id: UUID = UUID(), text: String, colorHex: String, created: Date) {
        self.id = id
        self.text = text
        self.colorHex = colorHex
        self.created = created
    }
    
    var createdString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: created)
        }
    }
}

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
    
    func hexString() -> String {
        guard let components = cgColor?.components else {
            return ""
        }
        
        let red = UInt8(components[0] * 255.0)
        let green = UInt8(components[1] * 255.0)
        let blue = UInt8(components[2] * 255.0)
        
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}
