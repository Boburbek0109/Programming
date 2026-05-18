//
//  ListingImageCorouselView.swift
//  Programming
//
//  Created by Bobur Sobirjanov on 5/16/26.
//

import SwiftUI

struct ListingImageCorouselView: View{
    
    let listing: Listing
    
    var body: some View{
        TabView{
            ForEach(listing.imageURLs, id: \.self){ image in
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)

    }
}

#Preview {
    ListingImageCorouselView(listing: DeveloperPreview.shared.listings[0])
}
