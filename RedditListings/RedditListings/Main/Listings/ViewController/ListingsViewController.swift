//
//  ListingsViewController.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit
import Combine
import SwiftUI

class ListingsViewController: ListViewController<ListingViewModel, ListingsViewModel> {

    // MARK: Lifecycle
    
    override init(didTapItem: ((ListingViewModel) -> Void)? = nil, pagingSize: Int = 20) {
        super.init(didTapItem: didTapItem)
        
        /// Set did Tap Item for navigation, but allow overriding
        self.didTapItem = didTapItem ?? navigateTo
    }
                     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = StringConstants.listingsTitle
    }
    
    // MARK: Cell Configuration
    
    override func registerCells() {
        collectionView.register(ListingCell.self, forCellWithReuseIdentifier: ListingCell.reuseID)
    }
    
    override func dequeueConfigurableCell(forIndexPath indexPath: IndexPath) -> ListCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: ListingCell.reuseID, for: indexPath) as! ListingCell
    }
    
    // MARK: Navigation

    private func navigateTo(listing: ListingViewModel){
        navigationController?.pushViewController(ListingDetailViewController(withListing: listing), animated: true)
    }

}
