//
//  ListingDetailHeaderCell.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import UIKit

class ListingDetailHeaderCell: CommentCell {
    
    // MARK: Properties
    
    override class var reuseID: String {
        "ListingDetailHeaderCell"
    }
    
    override var imageViewHeight: CGFloat {
        return 150
    }
    
    override func configure(with item: ListCellDataProtocol) {
        super.configure(with: item)
        
        self.bodyTextView.text = item.title
    }
    
    
    /// Override to add more content to cell
    override func getStackContent() -> UIView {
        titleLabel.numberOfLines = 0
        imageView.layer.cornerRadius = 0
        imageView.contentMode = .scaleAspectFit
        return stack (
            imageView
                .withHeight(imageViewHeight),
            bodyTextView,
            subtitleLabel,
            captionLabel
            )
    }
    
}
