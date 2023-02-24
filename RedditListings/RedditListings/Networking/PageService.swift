//
//  PageService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import Foundation

class PageService<PageData: Decodable> {
    
    func fetchPage(from urlString: String,
                   completion: @escaping (Result<PageData, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.URLFormatting))
            return
        }
        
        let request = Request<PageData>(url: url)
        WebService.execute(request: request) { res in
            completion(res)
        }
    }
    
}
