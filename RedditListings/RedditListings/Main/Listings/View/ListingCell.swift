//
//  ListingCell.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit

class ListingCell: ListCell {
    
    // MARK: Properties
    
    override class var reuseID: String {
        "ListingRowCell"
    }
    
    var rightArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: ImageConstants.chevronRight)
        iv.tintColor = .lightGray
        return iv
    }()
    
    // MARK: Views
    
    override func getStackContent() -> UIView {
        hstack(
            super.getStackContent(),
            stack (
                UIView(),
                rightArrow
                    .withWidth(20)
                    .withHeight(30),
                UIView()
            )

        )
    }
    
}

