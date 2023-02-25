//
//  PageService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import Foundation

class PageService<PageData: Decodable> {
    
    var inProgress: Set<String> = []
    
    func fetchPage(from urlString: String,
                   completion: @escaping (Result<PageData, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.urlFormatting))
            return
        }
        
        guard !inProgress.contains(urlString) else {
            completion(.failure(NetworkError.queryInProgress))
            return
        }
        
        let request = Request<PageData>(url: url)
        inProgress.insert(urlString)
        WebService.execute(request: request) { [weak self] res in
            completion(res)
            self?.inProgress.remove(urlString)
        }
    }
    
}
