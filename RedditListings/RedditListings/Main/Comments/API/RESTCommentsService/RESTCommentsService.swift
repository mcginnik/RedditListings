//
//  RESTCommentsService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import Foundation

import Foundation


class RESTCommentsService: CommentsServiceProtocol {
    
    func fetchPage(from urlString: String,
                       completion: @escaping (Result<[CommentPage], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.URLFormatting))
            return
        }
        
        
        let request = Request<[CommentPage]>(url: url)
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
