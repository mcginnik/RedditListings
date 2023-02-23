//
//  String+isValid.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import Foundation

extension String {
    
    enum RegularExpressions: String {
        case url = "http"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
}
