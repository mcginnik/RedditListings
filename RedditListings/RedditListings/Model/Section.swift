//
//  Section.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

enum SectionType: String, Decodable {
    case tableRow
    case tableSmallRectangle
    case tableMediumRectangle
    case tableLargeSquare
}

struct Section: Decodable, Hashable {
    let id: Int
    let type: SectionType
    let title: String
    let subtitle: String
    let items: [ListingData]
}
