//
//  ListingViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit
import Combine

class ListingViewModel: ObservableObject {
    
    // MARK: Properties
    
    let listingData: ListingData
    
    var id: String {
        return listingData.id
    }
    
    var title: String {
        return listingData.title
    }
    
    var author: String {
        return listingData.author
    }
    
    var formattedAuthor: String {
        return "@\(author)"
    }
    
    var subtitle: String? {
        return listingData.subtitle
    }
    
    var body: String? {
        return listingData.body
    }
    
    var imageURL: String? {
        listingData.thumbnail
    }
            
    // MARK: Lifecycle
    
    init(withData listingData: ListingData){
        self.listingData = listingData
    }
    
    func fetchImage(completion: @escaping (Result<(UIImage, String), Error>) -> Void){
        guard let imageURL = imageURL else { return }
        ImageService.shared.fetchImage(imageURL) { res in
            DispatchQueue.main.async { [ weak self ] in
                guard let strongSelf = self else { return }
                switch res {
                case .success(let image):
                    completion(.success((image, imageURL)))
                    Logging.LogMe("Success!  \(strongSelf.title): imageurl string \(imageURL)")
                case .failure(let error):
                    completion(.failure(error))
                    Logging.LogMe("Failed! \(error)")
                }
            }
        }
    }

    
}
