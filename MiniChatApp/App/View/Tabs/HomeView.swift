//
//  HomeView.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/13/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 10) {
                NavigationLink(value: "Detail View"){
                    Rectangle()
                        .fill(.blue)
                        .frame(height: 45)
                }
                ScrollView(.horizontal){
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(.red)
                            .containerRelativeFrame(.horizontal)
                        
                        Rectangle()
                            .fill(.green)
                            .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetBehavior(.paging)
                .frame(height: 220)
            }
        }
    }
}
