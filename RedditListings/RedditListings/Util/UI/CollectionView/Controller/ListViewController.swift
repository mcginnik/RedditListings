////
////  ListViewController.swift
////  RedditListings
////
////  Created by Kyle McGinnis on 2/23/23.
////
//
//import UIKit
//import Combine
//import SwiftUI
//
//
//protocol ListViewModelDataProtocol {
//}
//
//protocol ListViewModelProtocol: ObservableObject {
//    associatedtype D: ListViewModelDataProtocol
//    var listings: [D] { get set }
//    var cellHeight: CGFloat { get }
//    func fetchNextPage()
//    init()
//}
//
//protocol SectionRowCellProtocol: CellConfiguring, UICollectionViewCell {
//    associatedtype D: ListViewModelDataProtocol
//    static var reuseID: String { get }
//}
//
//protocol ListViewControllerProtocol {
//    associatedtype C: SectionRowCellProtocol
//}
//
//class ListViewController<C: SectionRowCellProtocol>: UIViewController,
//                                                     UICollectionViewDataSource,
//                                                     UICollectionViewDelegate,
//                                                     UICollectionViewDelegateFlowLayout {
//    
//    // MARK: Properties
//    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv =  UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        cv.backgroundColor = .systemBackground
//        return cv
//    }()
//
//    @ObservedObject var viewModel: VM = VM()
//    
//    var listings: [VM.D] {
//        self.viewModel.listings
//    }
//    
//    var cancellables: Set<AnyCancellable> = []
//    var didTapItem: (_ listing: VM.D) -> Void = { _ in }
//
//    // MARK: Lifecycle
//    
//    init(didTapItem: ((VM.D) -> Void)? = nil) {
//        super.init(nibName: nil, bundle: nil)
//        
//        // Set did Tap Item for navigation, but allow overriding
//        self.didTapItem = didTapItem ?? navigateTo
//    }
//                     
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//                     
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        setupSubscriptions()
//        fetchNextPage()
//    }
//    
//    private func setupViews(){
//        view.backgroundColor = .systemBackground
//        setupTitle()
//        setupCollectionView()
//    }
//    
//    private func setupCollectionView(){
//        view.addSubview(collectionView)
//        collectionView.register(C.self, forCellWithReuseIdentifier: C.reuseID)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.reloadData()
//    }
//    
//    private func setupTitle(){
//        navigationController?.navigationBar.prefersLargeTitles = true
//        self.title = StringConstants.listingsTitle
//    }
//    
//    // MARK: Subscriptions
//    
//    private func setupSubscriptions(){
//        //
//    }
//    
//    // MARK: API
//    
//    private func didLoadCellAtIndex(_ index: Int){
//        // Fetch Next Page if we are at the end of the list
//        if index == listings.count - 1{
//            fetchNextPage()
//        }
//    }
//    
//    private func fetchNextPage(){
//        viewModel.fetchNextPage()
//    }
//    
//    // MARK: UICollectionView DataSource & Delegate Conformance
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        didTapItem(listings[indexPath.item])
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listings.count
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.reuseID,
//                                                      for: indexPath) as! C
//        let listing = listings[indexPath.item]
//        
//        cell.configure(with: listing)
//        
//        didLoadCellAtIndex(indexPath.item)
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = view.frame.width
//        let height = viewModel.cellHeight
//        return CGSize(width: width, height: height)
//    }
//
//}
//
//// MARK: Navigation
//
//extension ListViewController {
//    
//    func navigateTo(listing: VM.D){
//        //
//    }
//    
//    
//}
//
//extension ListViewController: ListViewControllerProtocol {}
