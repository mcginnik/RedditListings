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
    
    let model: Listing
    
    var id: String {
        return model.id
    }
    
    var title: String {
        return model.title ?? ""
    }
    
    var subtitle: String? {
        model.subtitle
    }
    
    var caption: String {
        return "@\(model.author)"
    }
    
    var imageURL: String? {
        model.thumbnail
    }
            
    // MARK: Lifecycle
    
    init(withData model: Listing){
        self.model = model
    }

    
}

extension ListingViewModel: ListCellDataProtocol {}
