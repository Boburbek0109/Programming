//
//  CustomActionButton.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/15/26.
//

import SwiftUI

struct CustomActionButton: View {
    var isLargeHeader: Bool
    var icon: String
    var title: String
    var onTap: () -> () = { }
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 2) {
                Image(systemName: icon)
                    .font(.title3)
                    .frame(height: 30)
                
                Text(title)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 5)
            .background{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.background)
                        .opacity(isLargeHeader ? 0.8 : 1)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.ultraThinMaterial)
                        .opacity(isLargeHeader ? 0.8 : 0)
                        .environment(\.colorScheme, .dark)
                }
            }
        }
        .contentShape(.rect)
    }
}
