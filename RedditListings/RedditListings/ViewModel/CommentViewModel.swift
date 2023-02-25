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
        if let author = model.author {
            return "@\(author)"
        }
        return ""
    }
    
    var subtitle: String? {
        return model.subtitle
    }
    
    var imageURL: String? {
        let isValidURL = model.url?.isValid(regex: .jpgImageURL) ?? false
        return isValidURL ? model.url : model.thumbnail
    }
    
    var createdAt: Double {
        model.created ?? 0
    }
            
    // MARK: Lifecycle
    
    init(withData model: Comment){
        self.model = model
    }
    
}

extension CommentViewModel: ListCellDataProtocol {}

extension CommentViewModel: Hashable, Comparable {

    static func == (lhs: CommentViewModel, rhs: CommentViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func < (lhs: CommentViewModel, rhs: CommentViewModel) -> Bool {
        lhs.createdAt < rhs.createdAt
    }
    
}
