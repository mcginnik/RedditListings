//
//  Listing.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

struct ListingPage : Decodable {
    let kind: String
    let data: ItemList<Listing>
    
    var items: [Listing] {
        return data.children.map { $0.data }
    }
}

struct Listing: ItemProtocol, Equatable, Hashable {
    let id: String
    var title: String?
    var author: String?
    var subtitle: String?
    var body: String?
    var thumbnail: String?
    var url: String?
    let created: Double?
}
