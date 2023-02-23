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
            let listingSuffix = String(format: listings, self.rawValue)
            
            var url = baseURL + listingSuffix
            
            if let pagingSize = pagingSize {
                url += "?\(pagingLimitToken)\(pagingSize)"
            }
            
            if let cursor = cursor {
                url += "&\(pagingCursorToken)\(cursor)"
            }
            
            return url
        }
    }
    
    static let listings = "/r/all/%@.json"
    static let comments = "/comments/%@/.json"
    
    // MARK: Token separators
    
    static let pagingLimitToken = "limit="
    static let pagingCursorToken = "after="
    
    static func createCommentURLString(listingID: String, pagingSize: Int?, cursor: String?) -> String {
        let suffix = String(format: comments, listingID)
        
        var url = baseURL + suffix
        
        if let pagingSize = pagingSize {
            url += "?\(pagingLimitToken)\(pagingSize)"
        }
        
        if let cursor = cursor {
            url += "&\(pagingCursorToken)\(cursor)"
        }
        
        return url
    }

}
