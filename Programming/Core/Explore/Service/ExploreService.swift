//
//  ExploreService.swift
//  Programming
//
//  Created by Bobur Sobirjanov on 5/17/26.
//

import Foundation

class ExploreService {
    func fetchListings() async throws -> [Listing] {
        return DeveloperPreview.shared.listings
    }
}
