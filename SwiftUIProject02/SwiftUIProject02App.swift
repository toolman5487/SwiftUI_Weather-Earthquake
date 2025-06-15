//
//  SwiftUIProject02App.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

@main
struct SwiftUIProject02App: App {
    
    @StateObject private var notificationManager = NotificationManager.shared
    
    var body: some Scene {
        WindowGroup {
            TabMainView()
                .environment(\.colorScheme, .dark)
                .onAppear {
                    notificationManager.requestAuthorization()
                }
        }
    }
}
