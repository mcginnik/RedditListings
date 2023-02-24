//
//  ItemList.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import Foundation

protocol ItemProtocol: Decodable {
    var id: String { get }
    var title: String? { get set }
    var author: String { get set }
    var subtitle: String? { get set }
    var body: String? { get set }
    var thumbnail: String? { get set }
}

struct ItemList<Item: ItemProtocol>: Decodable {
    let children: [ItemContainer<Item>]
    let modhash: String
}

struct ItemContainer<Item: ItemProtocol>: Decodable {
    let data: Item
    let kind: String?
}
