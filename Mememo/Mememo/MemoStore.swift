//
//  MemoStore.swift
//  Mememo
//
//  Created by wonyoul heo on 4/22/24.
//

import Foundation
import SwiftUI

struct Memo: Identifiable {
    var id: UUID = UUID()
    var text: String
    var color: Color
    var created: Date
    
    var createdString: String{
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: created)
        }
    }
}

class MemoStore: ObservableObject {
    @Published var memos: [Memo] = []
    
    func addMemo(_ text: String, color: Color) {
        let memo: Memo = Memo(text: text, color: color, created: Date())
        memos.insert(memo, at: 0)
    }
    
    func removeMemo(_ targetMemo: Memo) {
        if let index = memos.firstIndex(where: {$0.id == targetMemo.id}) {
            memos.remove(at: index)
        }
    }
}
