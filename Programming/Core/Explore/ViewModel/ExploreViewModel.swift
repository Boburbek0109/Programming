//
//  ExploreViewModel.swift
//  Programming
//
//  Created by Bobur Sobirjanov on 5/17/26.
//

import Foundation
import Combine

class ExploreViewModel: ObservableObject{
    @Published var listings = [Listing]()
    @Published var searchLocation = ""
    private let service: ExploreService
    private var listingsCopy = [Listing]()
    
    init(service: ExploreService){
        self.service = service
        
        Task { await fetchListing()}
    }
    
    func fetchListing() async {
        do {
            self.listings = try await service.fetchListings()
            self.listingsCopy = listings
        } catch {
            print ("DEBUG: failed to fetch listings with error: \(error.localizedDescription)")
        }
    }
    
    func updatedListingForLocation() {
        let filteredListings = listings.filter({
            $0.city.lowercased() == searchLocation.lowercased() ||
            $0.state.lowercased() == searchLocation.lowercased()
        })
        
        self.listings = filteredListings.isEmpty ? listingsCopy : filteredListings
    }
}
