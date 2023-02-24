//
//  CommentViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import UIKit
import Combine

class CommentViewModel: ObservableObject {
    
    // MARK: Properties
    
    let model: Comment
    
    var id: String {
        return model.id
    }
    
    var body: String {
        return model.body ?? ""
    }
    
    var title: String {
        model.author
    }
    
    var caption: String {
        return "@\(model.author)"
    }
    
    var subtitle: String? {
        return model.subtitle
    }
    
    var imageURL: String? {
        model.thumbnail
    }
            
    // MARK: Lifecycle
    
    init(withData model: Comment){
        self.model = model
    }
    
}

extension CommentViewModel: ListCellDataProtocol {}
