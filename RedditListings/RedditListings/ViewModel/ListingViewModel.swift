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
    
    var body: String? {
        return model.body
    }
    
    var title: String {
        return model.title ?? ""
    }
    
    var subtitle: String? {
        model.subtitle
    }
    
    var caption: String {
        if let author = model.author {
            return "@\(author)"
        }
        return ""
    }
    
    var imageURL: String? {
        model.thumbnail
    }
    
    var createdAt: Double {
        model.created ?? 0
    }
            
    // MARK: Lifecycle
    
    init(withData model: Listing){
        self.model = model
    }

    
}

extension ListingViewModel: ListCellDataProtocol {}

extension ListingViewModel: Hashable, Comparable {

    static func == (lhs: ListingViewModel, rhs: ListingViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func < (lhs: ListingViewModel, rhs: ListingViewModel) -> Bool {
        lhs.createdAt < rhs.createdAt
    }
    
}
