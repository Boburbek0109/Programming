//
//  UserProfile.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/15/26.
//

import FirebaseFirestore

struct UserProfile: Codable, Identifiable{
    @DocumentID var id: String?
    
    var uid: String
    var username: String
    var bio: String?
    var avatarUrl: String?
    var birthDate: Date?
    
}
