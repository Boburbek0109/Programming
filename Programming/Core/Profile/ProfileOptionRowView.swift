//
//  ProfileOptionRowView.swift
//  Programming
//
//  Created by Bobur Sobirjanov on 5/17/26.
//

import SwiftUI

struct ProfileOptionRowView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                
                Text(title)
                    .font(.subheadline)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            Divider()
        }
    }
}
