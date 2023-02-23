//
//  ListingPage.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

struct ListingPage : Decodable {
    let kind: String
    let data: ListingPageData
    
    var children: [Listing] {
        return data.children
    }
}

struct ListingPageData: Decodable {
    let after: String
    let before: String?
    let children: [Listing]
    let dist: Int
    let modhash: String
}
