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
    
    let innerData: CommentData
    
    var id: String {
        return innerData.id
    }
    
    var body: String {
        return innerData.body ?? ""
    }
    
    var title: String {
        innerData.author
    }
    
    var caption: String {
        return "@\(innerData.author)"
    }
    
    var subtitle: String? {
        return innerData.subtitle
    }
    
    var imageURL: String? {
        innerData.thumbnail
    }
            
    // MARK: Lifecycle
    
    init(withData data: CommentData){
        self.innerData = data
    }
    
}

extension CommentViewModel: SectionCellDataProtocol {}
