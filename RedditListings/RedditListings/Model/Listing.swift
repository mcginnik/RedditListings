//
//  Listing.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

struct ListingPage : Decodable {
    let kind: String
    let data: ListingList
    
    var items: [Listing] {
        return data.children.map { $0.data }
    }
}

struct ListingList: Decodable {
    let children: [ListingContainer]
    let modhash: String
    
    //    let after: String
    //    let before: String?
    //    let children: [Listing]
    //    let dist: Int
    //    let modhash: String
}


struct ListingContainer: Decodable {
    let data: Listing
    let kind: String?
}

struct Listing: Decodable, Equatable, Hashable {
    let id: String
    let title: String?
    let author: String
    let subtitle: String?
    let body: String?
    let thumbnail: String?
}

