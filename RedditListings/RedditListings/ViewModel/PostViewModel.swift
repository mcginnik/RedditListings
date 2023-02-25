//
//  PostViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit
import Combine

class PostViewModel: ObservableObject {
    
    // MARK: Properties
    
    let model: Post
    
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
    
    required init(withData model: Post){
        self.model = model
    }

    
}

extension PostViewModel: ListCellDataProtocol {
    typealias P = PostPage
}

extension PostViewModel: Hashable, Comparable {

    static func == (lhs: PostViewModel, rhs: PostViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func < (lhs: PostViewModel, rhs: PostViewModel) -> Bool {
        lhs.createdAt < rhs.createdAt
    }
    
}
