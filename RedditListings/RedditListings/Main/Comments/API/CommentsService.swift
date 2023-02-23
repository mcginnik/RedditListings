//
//  CommentsService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import Foundation

protocol CommentsServiceProtocol {
    func fetchPage(from urlString: String,
                   completion: @escaping (Result<[CommentPage], Error>) -> Void)
}

enum CommentsServiceError: LocalizedError {
    case emptyData

    var errorDescription: String? {
        switch self {
        case .emptyData:
            return "Message data is empty..."
        }
    }
}

class CommentsService {
    
    // MARK: Properties
    
    static let shared = CommentsService()

    /// Allowing for Dependency injection here, calling the injected service instead of directly  so you can easily swap out if need be
    /// Would instead have this be an automatic static injection setup so that all services are set at complie time, but this is a simple way of doing it for now
    ///
    var injected: CommentsServiceProtocol?
    
    // MARK: Lifecycle
    
    private init(){}
    
    static func setup(with service: CommentsServiceProtocol){
        self.shared.injected = service
    }
    
    // MARK: API
    
    func fetchPage(from urlString: String,
                   completion: @escaping (Result<[CommentPage], Error>) -> Void) {
        Logging.LogMe("... \(urlString)")
        
        injected?.fetchPage(from: urlString) { res in
            DispatchQueue.main.async {
                switch res {
                case .success:
                    Logging.LogMe("Success!...")
                case .failure(let error):
                    Logging.LogMe("Failed! ... \(error)")
                }
                completion(res)
            }
        }
    }

    
}
