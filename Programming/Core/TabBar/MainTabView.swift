//
//  MainTabView.swift
//  Programming
//
//  Created by Bobur Sobirjanov on 5/17/26.
//

import SwiftUI

struct MainTabView: View{
    var body: some View{
        TabView{
            ExploreView()
                .tabItem{
                    Label("Explore", systemImage: "magnifyingglass")
                }
            
            WishlistsView()
                .tabItem{
                    Label("Wishlists", systemImage: "heart")
                }
            
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person")
            }
        }
    }
}
