//
//  Comment.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

struct Comment: Decodable {
    let data: CommentData
    let kind: String?
}

struct CommentData: Decodable, Equatable, Hashable {
    let id: String
    let title: String
    let author: String
    let subtitle: String?
    let body: String?
    let thumbnail: String?
}
