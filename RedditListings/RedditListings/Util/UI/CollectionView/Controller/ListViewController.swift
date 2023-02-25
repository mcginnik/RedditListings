//
//  ListViewController.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import UIKit
import Combine
import SwiftUI


class ListViewController<CD: ListCellDataProtocol, VM: ListViewModel<CD>>: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv =  UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.backgroundColor = .systemBackground
        return cv
    }()

    @ObservedObject var viewModel: VM
    
    var items: [CD] {
        self.viewModel.data
    }
    
    var cancellables: Set<AnyCancellable> = []
    var didTapItem: (_ item: CD) -> Void = { _ in }

    // MARK: Lifecycle
    
    init(didTapItem: ((CD) -> Void)? = nil, pagingSize: Int = 20) {
        self.viewModel = VM(pagingSize: pagingSize)
        super.init(nibName: nil, bundle: nil)
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
        collectionView.fillSuperview()
        registerCells()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    /// Override in Subclass
    func registerCells(){
        //
    }
    
    /// Override in Subclass
    func setupTitle(){
        //
    }
    
    // MARK: Subscriptions
    
    private func setupSubscriptions(){
        viewModel.$data.sink { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        .store(in: &cancellables)
    }
    
    // MARK: API
    
    private func didLoadCellAtIndex(_ index: Int){
        // Fetch Next Page if we are at the end of the list
        if index == items.count - 1{
            fetchNextPage()
        }
    }
    
    private func fetchNextPage(){
        viewModel.fetchNextPage()
    }
    
    // MARK: UICollectionView DataSource & Delegate Conformance

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapItem(items[indexPath.item])
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = dequeueConfigurableCell(forIndexPath: indexPath)
        let item = items[indexPath.item]
        
        cell.configure(with: item)
        
        didLoadCellAtIndex(indexPath.item)
        
        return cell
    }
    
    /// Override in Subclass
    func dequeueConfigurableCell(forIndexPath indexPath: IndexPath) -> ListCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reuseID,
                                                      for: indexPath) as! ListCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = viewModel.cellHeight(forIndexPath: indexPath)
        return CGSize(width: width, height: height)
    }
    
}
