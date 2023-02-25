//
//  ListingDetailViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import Foundation
import Combine
import SwiftUI

class ListingDetailViewModel: ListViewModel<CommentViewModel> {
    
    // MARK: Properties
    
    let listingID: String
    
    override var fullURL: String {
        Endpoints.createCommentURLString(listingID: listingID,
                                         pagingSize: pagingSize,
                                         cursor: data.last?.id)
    }
    
    // MARK: Lifecycle
    
    init(listingID: String, pagingSize: Int = 20) {
        self.listingID = listingID
        super.init(pagingSize: pagingSize)
        fetchPageFromURL = ListingDetailService.shared.fetchPage
    }
    
    // MARK: Helpers
    
    override func cellHeight(forIndexPath indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 200
        if indexPath.item == 0 {
            return height * 1.5
        }
        return height
    }
    
}
