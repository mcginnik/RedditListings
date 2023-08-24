//
//  PostDetailViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import Foundation
import Combine
import SwiftUI

class PostDetailViewModel: ListViewModel<CommentViewModel> {
    
    // MARK: Properties
    
    var postID: String = ""
    
    override var fullURL: String {
        let res = Endpoints.createCommentURLString(postID: postID,
                                         pagingSize: pagingSize,
                                         cursor: data.last?.id)
        Logging.LogMe("... \(res)")
        return res
    }
    
    // MARK: Lifecycle
    
    required init(pagingSize: Int) {
        super.init(pagingSize: pagingSize)
        
        /// Set Page Fetching Service
        fetchPageFromURL = PostDetailService.shared.fetchPage
    }
    
    
    // MARK: Helpers
    
    func setPostID(_ id: String){
        self.postID = id
    }
    
    override func cellHeight(forIndexPath indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 200
        if indexPath.item == 0 {
            return height * 1.5
        }
        return height
    }
    
}
