//
//  PostsViewController.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit
import Combine
import SwiftUI

class PostsViewController: ListViewController<PostViewModel, PostsViewModel> {

    // MARK: Lifecycle
    
    override init(didTapItem: ((PostViewModel) -> Void)? = nil, pagingSize: Int = 20) {
        super.init(didTapItem: didTapItem)
        
        /// Set did Tap Item for navigation, but allow overriding
        self.didTapItem = didTapItem ?? navigateTo
    }
                     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = StringConstants.postsTitle
    }
    
    // MARK: Cell Configuration
    
    override func registerCells() {
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseID)
    }
    
    override func dequeueConfigurableCell(forIndexPath indexPath: IndexPath) -> ListCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseID, for: indexPath) as! PostCell
    }
    
    // MARK: Navigation

    private func navigateTo(post: PostViewModel){
        navigationController?.pushViewController(PostDetailViewController(withPost: post), animated: true)
    }

}
