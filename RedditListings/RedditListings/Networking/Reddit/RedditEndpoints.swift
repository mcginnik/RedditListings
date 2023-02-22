//
//  RedditEndpoints.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

struct RedditEndpoints {
    static let allNew = "/r/all/new.json"
    
    // Token separators
    static let pagingLimitToken = "limit="
    static let pagingCursorToken = "after="

}
