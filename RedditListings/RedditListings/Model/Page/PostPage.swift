//
//  PostPage.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import Foundation

struct PostPage: PageProtocol, Decodable {
    let kind: String
    let data: ItemList<Post>
    
    var items: [Post] {
        return data.children.map { $0.data }
    }
}
