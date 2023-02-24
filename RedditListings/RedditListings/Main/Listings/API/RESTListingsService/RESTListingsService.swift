//
//  RESTListingsService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation


class RESTListingsService: ListingsServiceProtocol {
    
    func fetchPage(from urlString: String,
                   completion: @escaping (Result<ListingPage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.URLFormatting))
            return
        }
        
        
        let request = Request<ListingPage>(url: url)
        WebService.execute(request: request) { (res) in
            completion(res)
        }
    }
    
}
