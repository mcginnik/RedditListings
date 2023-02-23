//
//  ListingDetailViewController.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit

class ListingDetailViewController: UIViewController {
    
    // MARK: Properties

    let viewModel: ListingViewModel
    
    // MARK: Lifecycle

    init(withListing listing: ListingViewModel){
        self.viewModel = listing
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    // MARK: Views
    
    private func setupViews(){
        navigationController?.navigationBar.prefersLargeTitles = false
        self.title = viewModel.title
    }


}
