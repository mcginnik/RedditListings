//
//  ListCell.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import UIKit

class ListCell: UICollectionViewCell, CellConfiguring {
    
    // MARK: Properties
    
    class var reuseID: String {
        ""
    }
    
    let titleLabel = UILabel()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private var separator: UIView {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.25)
        return view
    }
    

    
    var imageViewHeight: CGFloat {
        return self.frame.height * 0.7
    }
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = .init(x: 0, y: 0, width: imageViewHeight, height: imageViewHeight)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = iv.frame.width / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    var imageURL: String?
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Setup
    
    private func setupViews(){
        contentView.stack(
            getLabelContent(),
            UIView().withHeight(4),
            separator.withHeight(1)
        ).withMargins(.allSides(8))
    }
    
    /// Override to add more content to cell
    func getLabelContent() -> UIView {
        hstack(
            stack (
                UIView(),
            imageView
                .withWidth(imageViewHeight)
                .withHeight(imageViewHeight),
                UIView()
            ),
            UIView().withWidth(8),
            stack(
                titleLabel,
                subtitleLabel,
                captionLabel
            ).withMargins(.allSides(2))
        )
    }
    
    // MARK: Cell Configuration
    
    func configure(with item: ListCellDataProtocol) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        captionLabel.text = item.caption
        
        configureImageView(with: item)
    }
        
    private func configureImageView(with item: ListCellDataProtocol){

        if self.imageURL != item.imageURL {
            self.imageView.image = nil
        }
        
        self.imageURL = item.imageURL
        
        item.fetchImage{[weak self] res in
            switch res {
            case .success((let image, let url)):
                if url == self?.imageURL {
                    self?.imageView.image = image
                }
            case .failure(let error):
//                Logging.LogMe("Failed! \(error)")
                self?.imageView.image = UIImage(named: ImageConstants.logo)
            }
        }
    }
    

}
