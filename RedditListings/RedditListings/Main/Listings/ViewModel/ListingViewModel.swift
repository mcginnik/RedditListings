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
    
    var subtitle: String? {
        listingData.subtitle
    }
    
    var caption: String {
        return "@\(listingData.author)"
    }
    
    var imageURL: String? {
        listingData.thumbnail
    }
            
    // MARK: Lifecycle
    
    init(withData listingData: ListingData){
        self.listingData = listingData
    }

    
}

extension ListingViewModel: SectionCellDataProtocol {}
