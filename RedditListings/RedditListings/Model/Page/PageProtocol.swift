//
//  PageProtocol.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import Foundation

protocol PageProtocol {
    associatedtype I: ItemProtocol
    var items: [I] { get }
}
