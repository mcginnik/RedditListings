//
//  SectionCell.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit

class SectionCell: UICollectionViewCell, CellConfiguring {    
    
    // Properties
    
    static let reuseID: String = "SectionCell"

    let title = UILabel()
    let subtitle = UILabel()
    let body = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle(){
        
    }
    
    func setupSubTitle(){
        
    }
    
    func setupBody() {
        
    }

    func configure(with item: ListingViewModel) {
        title.text = item.title
        subtitle.text = item.subtitle
        body.text = item.body
//        imageView.image = UIImage(
    }
}
