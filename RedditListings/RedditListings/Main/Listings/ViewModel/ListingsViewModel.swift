//
//  ListingsViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation
import Combine

class ListingsViewModel: ObservableObject {
    
    // MARK: Properties
    
    let baseURL: String = AppConfig.shared.baseURLString
    let topic: Endpoints.Topic
    
    var fullURL: String {
        topic.createListingsURLString(pagingSize: pagingSize, cursor: viewModels.last?.id)
    }
    
    let pagingSize: Int
    
    var cellHeight: CGFloat {
        80
    }
    
    @Published var viewModels: [ListingViewModel] = []
    
    // MARK: Lifecycle
    
    init(withTopic topic: Endpoints.Topic, pagingSize: Int = 20){
        self.topic = topic
        self.pagingSize = pagingSize
    }
    
    // MARK: API
    
    func fetchNextPage(){
        
        ListingsService.shared.fetchPage(from: fullURL) { [weak self] res in
            switch res {
            case .success(let pages):
                for page in pages {
                    self?.viewModels.append(contentsOf: page.items.compactMap{ListingViewModel(withData: $0)})
                }
                Logging.LogMe("... Success! \(pages)")
            case .failure(let error):
                Logging.LogMe("... FAILED! \(error)")
            }
        }
    }
    
}
