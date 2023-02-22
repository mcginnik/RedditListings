//
//  ListingViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation
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
    
    var subtitle: String? {
        return listingData.subtitle
    }
    
    var body: String? {
        return listingData.body
    }
    
    var url: URL? {
        if let url = listingData.url {
            return URL(string: url)
        }
        return nil
    }
    
    // MARK: Lifecycle
    
    init(withData listingData: ListingData){
        self.listingData = listingData
    }

    
}
