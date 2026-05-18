//
//  ProfileView.swift
//  Programming
//
//  Created by Bobur Sobirjanov on 5/17/26.
//

import SwiftUI

struct ProfileView: View{
    var body: some View{
        VStack{
            // profile login view
            VStack(alignment: .leading, spacing: 12){
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Profile")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Text("Log in to start planning your next trip")
                }
                
                Button{
                    print("Log In")
                } label: {
                    Text("Log In")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 48)
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                HStack{
                    Text("Don't have an accaunt")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                        .underline()
                }
                .font(.caption)
            }
            
            VStack(spacing: 24) {
                ProfileOptionRowView(imageName: "gear", title: "Setting")
                
                ProfileOptionRowView(imageName: "gear", title: "Accessibility")
                
                ProfileOptionRowView(imageName: "questionmark.circle", title: "Visit the help center")
            }
            .padding(.horizontal)
        }
        .padding()
    }
}



#Preview {
    ProfileView()
}
