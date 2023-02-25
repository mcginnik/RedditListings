//
//  ItemViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/25/23.
//

import UIKit
import Combine

class ItemViewModel<Item: ItemProtocol>: ObservableObject {
    
    // MARK: Properties
    
    let model: Item
    
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
    
    required init(withData model: Item){
        self.model = model
    }

    
}

extension ItemViewModel: Hashable, Comparable {

    static func == (lhs: ItemViewModel, rhs: ItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func < (lhs: ItemViewModel, rhs: ItemViewModel) -> Bool {
        lhs.createdAt < rhs.createdAt
    }
    
}
