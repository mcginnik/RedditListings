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
    
    var listingID: String = ""
    
    override var fullURL: String {
        Endpoints.createCommentURLString(listingID: listingID,
                                         pagingSize: pagingSize,
                                         cursor: data.last?.id)
    }
    
    // MARK: Lifecycle
    
    required init(pagingSize: Int) {
        super.init(pagingSize: pagingSize)
        
        /// Set Page Fetching Service
        fetchPageFromURL = ListingDetailService.shared.fetchPage
    }
    
    
    // MARK: Helpers
    
    func setListingID(_ id: String){
        self.listingID = id
    }
    
    override func cellHeight(forIndexPath indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 200
        if indexPath.item == 0 {
            return height * 1.5
        }
        return height
    }
    
}
