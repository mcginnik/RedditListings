//
//  ListingPage.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import Foundation

struct ListingPage: PageProtocol, Decodable {
    let kind: String
    let data: ItemList<Listing>
    
    var items: [Listing] {
        return data.children.map { $0.data }
    }
}
