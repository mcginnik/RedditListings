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
    
    var idSet: Set<String> = []
    
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
                    if !strongSelf.idSet.contains(item.id) {
                        strongSelf.viewModels.append(ListingViewModel(withData: item))
                        strongSelf.idSet.insert(item.id)
                    } else {
                        Logging.LogMe("Skipping!  Alraady Exists.")
                    }
                }
            case .failure(let error):
                Logging.LogMe("... FAILED! \(error)")
            }
        }
    }
    
}
