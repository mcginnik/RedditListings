//
//  Listing.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

struct Listing: Decodable {
    let data: ListingData
    let kind: String?
}

struct ListingData: Decodable, Equatable, Hashable {
    let id: String
    let title: String
    let author: String
    let subtitle: String?
    let body: String?
    let thumbnail: String?
}
