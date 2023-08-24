//
//  CommentCell.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import UIKit

class CommentCell: ListCell {
    
    // MARK: Properties
    
    override class var reuseID: String {
        "CommentCell"
    }
    
    override var imageViewHeight: CGFloat {
        return 60
    }
    
    var bodyTextView: UITextView = {
        let tv = UITextView()
        tv.font = .preferredFont(forTextStyle: .body)
        return tv
    }()
    
    override func configure(with item: any ListCellDataProtocol) {
        super.configure(with: item)
        self.bodyTextView.text = item.body
    }
    // MARK: Views
    
    override func getStackContent() -> UIView {
        stack(
            super.getStackContent()
                .withHeight(60),
            bodyTextView
        )
    }

}
