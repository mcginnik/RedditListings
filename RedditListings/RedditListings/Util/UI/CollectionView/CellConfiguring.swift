//
//  CellConfiguring.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

protocol CellConfiguring {
    associatedtype Item
    static var reuseID: String { get }
    func configure(with item: Item)
}
