//
//  CommentPage.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import Foundation

struct CommentPage: PageProtocol, Decodable {
    let kind: String
    let data: ItemList<Comment>
    
    var items: [Comment] {
        return data.children.map { $0.data }
    }
}
