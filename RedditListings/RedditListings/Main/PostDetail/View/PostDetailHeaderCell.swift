//
//  PostDetailHeaderCell.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import UIKit

class PostDetailHeaderCell: ListCell {
    
    // MARK: Properties
    
    override class var reuseID: String {
        "PostDetailHeaderCell"
    }
    
    override var imageViewHeight: CGFloat {
        return 150
    }
    
    var bodyTextView: UITextView = {
        let tv = UITextView()
        tv.font = .preferredFont(forTextStyle: .body)
        return tv
    }()
    
    override func configure(with item: any ListCellDataProtocol) {
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
