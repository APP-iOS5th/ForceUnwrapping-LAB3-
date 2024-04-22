//
//  MemoWithSwiftDataApp.swift
//  MemoWithSwiftData
//
//  Created by 정종원 on 4/22/24.
//

import SwiftUI

@main
struct MemoWithSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Memo.self)
        }
    }
}
