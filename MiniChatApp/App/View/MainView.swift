//
//  MainView.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/13/26.
//

import SwiftUI
import FirebaseCore

enum AppRoute: Hashable{
    case settings
    case editProfile
}

struct MainView: View{
    @Environment(AuthViewModel.self) private var authVM
    
    @State private var activeTab = 0
    @State private var navigationPath: NavigationPath = .init()
    @State private var isOpen = false
//    @State private var safeAreaTopValue: CGFloat = 0
    
    var body: some View{
        
        let isMenuEnable = activeTab == 0 ? navigationPath.isEmpty : true
        
        CustomSideMenu(isEnabeld: isMenuEnable, isOpen: $isOpen) { progress in
            DummySideBar()
        } contetn: { progress in
            NavigationStack(path: $navigationPath){
                MainTabView(
                    activeTab: $activeTab,
                    onEditProfile: { navigationPath.append(AppRoute.editProfile) }
                )
                .toolbarVisibility(.hidden, for: .navigationBar)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route{
                    case .settings:
                        SettingsView()
                        
                    case .editProfile:
                        EditProfileView()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func DummySideBar() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Circle()
                .fill(.fill)
                .frame(width: 60, height: 60)
                .padding(.bottom, 10)
            
            Text(authVM.appUser?.username ?? "No username")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(authVM.appUser?.email ?? "")
                .foregroundStyle(.gray)
            
//            HStack(spacing: 10) {
//                Text("876 Following")
//                
//                Text("123 Followers")
//            }
//            .font(.callout)
//            .fontWeight(.medium)
            
            Button{
                isOpen = false
                navigationPath.append(AppRoute.settings)
            } label: {
                Label("Go to Settings", systemImage: "gearshape")
            }
            .padding(.top, 15)
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
    }
}

#Preview {
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }
    return MainView()
        .environment(AuthViewModel())
}
