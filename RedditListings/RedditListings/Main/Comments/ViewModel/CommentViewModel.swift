//
//  CommentViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import UIKit
import Combine

class CommentViewModel: ObservableObject {
    
    // MARK: Properties
    
    let innerData: CommentData
    
    var id: String {
        return innerData.id
    }
    
    var body: String {
        return innerData.body ?? ""
    }
    
    var author: String {
        return innerData.author
    }
    
    var formattedAuthor: String {
        return "@\(author)"
    }
    
    var subtitle: String? {
        return innerData.subtitle
    }
    
    var imageURL: String? {
        innerData.thumbnail
    }
            
    // MARK: Lifecycle
    
    init(withData data: CommentData){
        self.innerData = data
    }

    func fetchImage(completion: @escaping (Result<(UIImage, String), Error>) -> Void){
        guard let imageURL = imageURL else { return }
        ImageService.shared.fetchImage(imageURL) { res in
            DispatchQueue.main.async { [ weak self ] in
                guard let strongSelf = self else { return }
                switch res {
                case .success(let image):
                    completion(.success((image, imageURL)))
                    Logging.LogMe("Success!  \(strongSelf.body): imageurl string \(imageURL)")
                case .failure(let error):
                    completion(.failure(error))
                    Logging.LogMe("Failed! \(error)")
                }
            }
        }
    }
    
}
