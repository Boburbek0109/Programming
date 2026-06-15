//
//  ContentView.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/10/26.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AuthViewModel.self) private var authVM
    
    var body: some View {
        if authVM.user == nil{
            NavigationStack{
                LoginView()
            }
        } else {
            MainView()
        }        
    }
}
    
#Preview {
    ContentView()
        .environment(AuthViewModel())
}
