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
            guard let strongSelf = self else { return }
            switch res {
            case .success(let pages):
                for item in pages.flatMap({$0.items}) {
                    if let _ = strongSelf.viewModels.first(where: {$0.id == item.id }) {
                        continue
                    }
                    strongSelf.viewModels.append(ListingViewModel(withData: item))
                }
                Logging.LogMe("... Success! \(pages)")
            case .failure(let error):
                Logging.LogMe("... FAILED! \(error)")
            }
        }
    }
    
}
