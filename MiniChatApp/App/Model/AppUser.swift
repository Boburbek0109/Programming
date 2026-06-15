//
//  AppUser.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/14/26.
//

import FirebaseFirestore

struct AppUser: Codable, Identifiable {
    @DocumentID var id: String?
    var email: String
    var username: String
    var bio: String?
    var avatarURL: String?
    var birthDate: Date?
    
}
