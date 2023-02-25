//
//  ListingDetailViewController.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit
import Combine
import SwiftUI

class ListingDetailViewController: ListViewController<CommentViewModel, ListingDetailViewModel> {
    
    //MARK: Lifecycle

    init(withListing listing: ListingViewModel,
         didTapItem: ((CommentViewModel) -> Void)? = nil,
         pagingSize: Int = 20) {
        super.init(didTapItem: didTapItem, pagingSize: pagingSize)
        viewModel.setListingID(listing.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = StringConstants.commentsTitle
    }
    
    // MARK: Cell Configuration
    
    override func registerCells() {
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.reuseID)
        collectionView.register(ListingDetailHeaderCell.self, forCellWithReuseIdentifier: ListingDetailHeaderCell.reuseID)
    }
    
    override func dequeueConfigurableCell(forIndexPath indexPath: IndexPath) -> ListCell {
        let cell: ListCell
        if indexPath.item == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListingDetailHeaderCell.reuseID,
                                                      for: indexPath) as! ListingDetailHeaderCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.reuseID,
                                                      for: indexPath) as! CommentCell
        }
        return cell
    }
    
}

