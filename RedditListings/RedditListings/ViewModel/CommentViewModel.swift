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
    
    var body: String? {
        return model.body
    }
    
    var title: String {
        model.title ?? ""
    }
    
    var caption: String {
        model.author
    }
    
    var subtitle: String? {
        return model.subtitle
    }
    
    var imageURL: String? {
        let isValidURL = model.url?.isValid(regex: .jpgImageURL) ?? false
        return isValidURL ? model.url : model.thumbnail
    }
            
    // MARK: Lifecycle
    
    init(withData model: Comment){
        self.model = model
    }
    
}

extension CommentViewModel: ListCellDataProtocol {}
