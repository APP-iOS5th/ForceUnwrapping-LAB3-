//
//  MemoStore.swift
//  Mememo
//
//  Created by wonyoul heo on 4/22/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Memo {
    var id = UUID()
    var text: String
//    var color: Color
    var created: Date

    var createdString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            return dateFormatter.string(from: created)
        }
    }
    
    init(text: String) {
        self.text = text
        self.created = Date()
    }
}

//class MemoStore: ObservableObject {
//    @Published var memos: [Memo] =  []
//
//    func addMemo(_ text: String, color: Color) {
//        let memo = Memo(text: text, color: color, created: Date())
//
////        memos.append(memo) // 뒤에 추가
//        memos.insert(memo, at: 0) // 앞에 추가
//    }
//
//    func removeMemo(_ targetMemo: Memo) {
////        var index: Int = 0
////        for tempMemo in memos {
////            if tempMemo.id == targetMemo.id {
////                memos.remove(at: index)
////                break
////            }
////            index += 1
////        }
//
//        memos = memos.filter { $0.id != targetMemo.id }
//    }
//}
