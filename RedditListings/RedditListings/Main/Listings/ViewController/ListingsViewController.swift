//
//  ListingsViewController.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit
import Combine
import SwiftUI

class ListingsViewController: UIViewController {
    
    // MARK: Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv =  UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.backgroundColor = .systemBackground
        return cv
    }()

    @ObservedObject var viewModel: ListingsViewModel = ListingsViewModel(withTopic: .new)
    
    var listings: [ListingViewModel] {
        self.viewModel.viewModels
    }
    
    var cancellables: Set<AnyCancellable> = []
    var didTapItem: (_ listing: ListingViewModel) -> Void = { _ in }

    // MARK: Lifecycle
    
    init(didTapItem: ((ListingViewModel) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        // Set did Tap Item for navigation, but allow overriding
        self.didTapItem = didTapItem ?? navigateTo
    }
                     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
                     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupSubscriptions()
        fetchNextPage()
    }
    
    private func setupViews(){
        view.backgroundColor = .systemBackground
        setupTitle()
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(ListingCell.self, forCellWithReuseIdentifier: ListingCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    private func setupTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = StringConstants.listingsTitle
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
        if index == listings.count - 1{
            fetchNextPage()
        }
    }
    
    private func fetchNextPage(){
        viewModel.fetchNextPage()
    }

}

// MARK: Navigation

extension ListingsViewController {
    
    private func navigateTo(listing: ListingViewModel){
        navigationController?.pushViewController(ListingDetailViewController(withListing: listing), animated: true)
    }
    
}

// MARK: UICollectionView DataSource & Delegate Conformance

extension ListingsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapItem(listings[indexPath.item])
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListingCell.reuseID,
                                                      for: indexPath) as! ListingCell
        let listing = listings[indexPath.item]
        
        cell.configure(with: listing)
        
        didLoadCellAtIndex(indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = viewModel.cellHeight
        return CGSize(width: width, height: height)
    }
    
}
