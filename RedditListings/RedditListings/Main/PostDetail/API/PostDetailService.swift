//
//  PostDetailService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

protocol PostDetailServiceProtocol {
    func fetchPage(from urlString: String,
                   completion: @escaping (Result<[CommentPage], Error>) -> Void)
}

enum PostDetailServiceError: LocalizedError {
    case emptyData

    var errorDescription: String? {
        switch self {
        case .emptyData:
            return "Message data is empty..."
        }
    }
}

class PostDetailService {
    
    // MARK: Properties
    
    static let shared = PostDetailService()

    /// Allowing for Dependency injection here, calling the injected service instead of directly  so you can easily swap out if need be
    /// Would instead have this be an automatic static injection setup so that all services are set at complie time, but this is a simple way of doing it for now
    ///
    var injected: PostDetailServiceProtocol?
    
    // MARK: Lifecycle
    
    private init(){}
    
    static func setup(with service: PostDetailServiceProtocol){
        self.shared.injected = service
    }
    
    // MARK: API
    
    func fetchPage(from urlString: String,
                   completion: @escaping (Result<[CommentPage], Error>) -> Void){
        Logging.LogMe("...")
        self.injected?.fetchPage(from: urlString) { res in
            completion(res)
        }
    }

    
}
