//
//  ListingsViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation
import Combine

class ListingsViewModel: ListViewModel<ListingViewModel> {
    
    private (set) var topic: Endpoints.Topic = .new
    
    override var fullURL: String {
        topic.createListingsURLString(pagingSize: pagingSize, cursor: data.last?.id)
    }
    
    required init(pagingSize: Int) {
        super.init(pagingSize: pagingSize)
        
        /// Set Page Fetching Service
        fetchPageFromURL = ListingsService.shared.fetchPage
    }
    
    func setTopic(_ topic: Endpoints.Topic){
        self.topic = topic
    }
    
}
