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
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        setupTitle()
    }
    
    func setupTitle(){
        contentView.addSubview(title)
        title.frame = .init(x: 0, y: 0, width: 200, height: 50)
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
