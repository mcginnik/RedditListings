//
//  ListingDetailViewController.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit
import Combine
import SwiftUI

class ListingDetailViewController: UIViewController {
    
    // MARK: Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv =  UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.backgroundColor = .systemBackground
        return cv
    }()

    @ObservedObject var viewModel: ListingDetailViewModel
    var cancellables: Set<AnyCancellable> = []

    
    var comments: [CommentViewModel] {
        self.viewModel.viewModels
    }
    
    // MARK: Lifecycle

    init(withListing listing: ListingViewModel){
        self.viewModel = ListingDetailViewModel(listingViewModel: listing)
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = StringConstants.commentsTitle
        setupViews()
        setupSubscriptions()
        fetchNextPage()
    }
    
    // MARK: Views
    
    private func setupViews(){
        view.backgroundColor = .systemBackground
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.reuseID)
        collectionView.register(ListingDetailHeaderCell.self, forCellWithReuseIdentifier: ListingDetailHeaderCell.reuseID)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }

    
    // MARK: Subscriptions
    
    private func setupSubscriptions(){
        viewModel.$viewModels.sink { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        .store(in: &cancellables)
    }
    
    // MARK: API
    
    private func didLoadCellAtIndex(_ index: Int){
        // Fetch Next Page if we are at the end of the list
        if index == comments.count - 1{
            fetchNextPage()
        }
    }
    
    private func fetchNextPage(){
        viewModel.fetchNextPage()
    }

}

// MARK: UICollectionView DataSource & Delegate Conformance

extension ListingDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        if indexPath.item == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListingDetailHeaderCell.reuseID,
                                                          for: indexPath) as! ListingDetailHeaderCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.reuseID,
                                                      for: indexPath) as! CommentCell
        }
        let listing = comments[indexPath.item]
        
        (cell as? CommentCell)?.configure(with: listing)
        
        didLoadCellAtIndex(indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = viewModel.cellHeight(forIndexPath: indexPath)
        return CGSize(width: width, height: height)
    }
    
}

