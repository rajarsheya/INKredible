//
//  INKredibleApp.swift
//  INKredible
//
//  Created by Arsheya Raj and Sunjil Gahatraj on 12/13/22.
//

import SwiftUI

@main
struct INKredibleApp: App {
    
    @Environment(\.scenePhase) var phase
    
    var body: some Scene {
        WindowGroup {
            ContentView(stateManager: AppStateManager.shared)
                .onChange(of: phase) { newPhase in
                    switch newPhase{
                    case .active:
                        print("App is in active state!")
                        AppStateManager.shared.isActive = true
                    case .inactive:
                        print("App is in inactive state!")
                        AppStateManager.shared.isActive = false
                    case .background:
                        print("App is in background state!")
                    @unknown default:
                        print("Unknown state!")
                    }
                    AppStateManager.shared.showBlur = AppStateManager.shared.isActive ? false : true
                }
        }
    }
}

class AppStateManager: ObservableObject {
    @Published var isActive = false
    @Published var showBlur = false
    
    static var shared = AppStateManager()
    
    private init() {}
}
