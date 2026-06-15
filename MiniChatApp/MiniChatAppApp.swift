//
//  MiniChatAppApp.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/10/26.
//

import SwiftUI
import FirebaseCore

//class AppDelegate: NSObject, UIApplicationDelegate{
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

@main
struct MiniChatAppApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var authVM: AuthViewModel
    
    init(){
        FirebaseApp.configure()
        _authVM = State(initialValue: AuthViewModel())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authVM)
        }
    }
}
