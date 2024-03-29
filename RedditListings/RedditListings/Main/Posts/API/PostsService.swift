//
//  PostsService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

protocol PostsServiceProtocol {
    func fetchPage(from urlString: String,
                   completion: @escaping (Result<PostPage, Error>) -> Void)
}

enum PostsServiceError: LocalizedError {
    case emptyData

    var errorDescription: String? {
        switch self {
        case .emptyData:
            return "Message data is empty..."
        }
    }
}

class PostsService {
    
    // MARK: Properties
    
    static let shared = PostsService()

    /// Allowing for Dependency injection here, calling the injected service instead of directly  so you can easily swap out if need be
    /// Would instead have this be an automatic static injection setup so that all services are set at complie time, but this is a simple way of doing it for now
    ///
    var injected: PostsServiceProtocol?
    
    // MARK: Lifecycle
    
    private init(){}
    
    static func setup(with service: PostsServiceProtocol){
        self.shared.injected = service
    }
    
    // MARK: API
    
    func fetchPage(from urlString: String,
                   completion: @escaping (Result<[PostPage], Error>) -> Void){
        Logging.LogMe("...")
        self.injected?.fetchPage(from: urlString) { res in
            DispatchQueue.main.async {
                switch res {
                case .success(let page):
                    Logging.LogMe("Success!...")
                    completion(.success([page]))
                case .failure(let error):
                    Logging.LogMe("Failed! ... \(error)")
                    completion(.failure(error))
                }
            }
        }
    }

    
}
