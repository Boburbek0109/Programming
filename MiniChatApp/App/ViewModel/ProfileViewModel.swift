//
//  ProfileViewModel.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/15/26.
//

import FirebaseFirestore

@Observable
final class ProfileViewModel{
    var profile: UserProfile?
    
    var username = ""
    var bio = ""
    var avatarURL: String?
    var birthDate: Date?
}
