//
//  MememoApp.swift
//  Mememo
//
//  Created by wonyoul heo on 4/22/24.
//

import SwiftUI
import SwiftData


@main
struct MememoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Memo.self)

        }
    }
}
