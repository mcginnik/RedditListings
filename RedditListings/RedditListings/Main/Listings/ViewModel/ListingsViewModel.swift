//
//  ListingsViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation
import Combine

class ListingsViewModel: ObservableObject {
    
    // MARK: Properties
    
    let baseURL: String = AppConfig.shared.baseURLString
    let endPoint: String
    
    var cellHeight: CGFloat {
        64
    }
    
    @Published var listings: [ListingViewModel] = []
    
    // MARK: Lifecycle
    
    init(withEndpoint endPoint: String){
        self.endPoint = endPoint
    }
    
    // MARK: API
    
    func fetchListings(){
        let url = baseURL + endPoint
        ListingsService.shared.fetchListings(from: url) { [weak self] res in
            switch res {
            case .success(let listingPage):
                let vms = listingPage.listings.compactMap{ListingViewModel(withData: $0.data)}
                self?.listings.append(contentsOf: vms)
                Logging.LogMe("... Success! \(listingPage)")
                
            case .failure(let error):
                Logging.LogMe("... FAILED! \(error)")
            }
        }
    }
    
}
