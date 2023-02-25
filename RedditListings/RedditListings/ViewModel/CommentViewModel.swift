//
//  CommentViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import UIKit
import Combine

class CommentViewModel: ItemViewModel<Comment> {
    
    // MARK: Properties
    
    override var imageURL: String? {
        let isValidURL = model.url?.isValid(regex: .jpgImageURL) ?? false
        return isValidURL ? model.url : model.thumbnail
    }
    
}

extension CommentViewModel: ListCellDataProtocol {
    typealias P = CommentPage
}
