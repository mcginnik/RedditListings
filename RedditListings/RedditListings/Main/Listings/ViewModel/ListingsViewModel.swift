//
//  ListingsViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation
import Combine

class ListingsViewModel: ListViewModel<ListingViewModel> {
    
    let topic: Endpoints.Topic
    
    override var fullURL: String {
        topic.createListingsURLString(pagingSize: pagingSize, cursor: data.last?.id)
    }
    
    init(withTopic topic: Endpoints.Topic, pagingSize: Int = 20) {
        self.topic = topic
        super.init(pagingSize: pagingSize)
        fetchPageFromURL = ListingsService.shared.fetchPage
    }
    
}
