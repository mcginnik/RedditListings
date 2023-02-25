//
//  Endpoints.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

struct Endpoints {
    
    // MARK: BaseURL
    
    static let baseURL = "https://www.reddit.com"
    
    // MARK: End Points
    
    enum Topic: String {
        case new
        case hot
        case random
        case top
        
        func createListingsURLString(pagingSize: Int?, cursor: String?) -> String {
            let suffix = String(format: listings, self.rawValue)
            let url = Endpoints.createURLString(suffix: suffix, pagingSize: pagingSize, cursor: cursor)
            return url
        }
    }
    
    static let listings = "/r/all/%@.json"
    static let comments = "/comments/%@/.json"
    
    // MARK: Token separators
    
    static let pagingLimitToken = "limit="
    static let pagingCursorAfterToken = "after="
    static let pagingCursorBeforeToken = "before="

    
    static func createCommentURLString(listingID: String, pagingSize: Int?, cursor: String?) -> String {
        let suffix = String(format: comments, listingID)
        let url = createURLString(suffix: suffix, pagingSize: pagingSize, cursor: cursor)
        Logging.LogMe("commenturl \(url)")
        return url
    }
    
    static func createURLString(baseURL: String = baseURL, suffix: String, pagingSize: Int?, cursor: String?) -> String {
        var url = baseURL + suffix
        if let pagingSize = pagingSize {
            url += "?\(pagingLimitToken)\(pagingSize)"
        }
        if let cursor = cursor {
            url += "&\(pagingCursorAfterToken)\(cursor)"
        }
        return url
    }

}
