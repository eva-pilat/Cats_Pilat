//
//  CatsAndModules_YevaPilat2App.swift
//  CatsAndModules_YevaPilat2
//
//  Created by Єва Матвєєва on 26.05.2025.
//

import SwiftUI
import Networking
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CatsAndModules_YevaPilat2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            CatsView()
        }
    }
}
