//
//  RESTListingsService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation


class RESTListingsService: ListingsServiceProtocol {
    
    func fetchListings(from urlString: String,
                       completion: @escaping (Result<ListingPage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.URLFormatting))
            return
        }
        
        
        let request = Request<ListingPage>(url: url)
        WebService.execute(request: request) { (res) in
            switch res {
            case .failure(let error):
                completion(.failure(error))
            case .success(let school):
                completion(.success(school))
            }
        }
    }
    
}