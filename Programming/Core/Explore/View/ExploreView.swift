//
//  ExploreView.swift
//  Programming
//
//  Created by Bobur Sobirjanov on 5/16/26.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var showDestinationSearchView = false
    @StateObject private var vm = ExploreViewModel(service: ExploreService())
    
    var body: some View {
        NavigationStack {
            
            if showDestinationSearchView {
                DestinationSearchView(show: $showDestinationSearchView, vm: vm)
            } else {
                ScrollView{
                    SearchAndFilterBar(location: $vm.searchLocation)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                showDestinationSearchView.toggle()
                            }
                        }
                    
                    LazyVStack(spacing: 32) {
                        ForEach(vm.listings) { listing in
                            NavigationLink(value: listing){
                                ListingItemView(listing: listing)
                                    .frame(height: 400)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    .padding()
                }
                .navigationDestination(for: Listing.self) { listing in
                    ListingDetailView(listing: listing)
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}


#Preview {
    ExploreView()
}
