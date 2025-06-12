//
//  SwiftUIProject02App.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

@main
struct SwiftUIProject02App: App {
    var body: some Scene {
        WindowGroup {
            TabMainView()
                .environment(\.colorScheme, .dark)
        }
    }
}

