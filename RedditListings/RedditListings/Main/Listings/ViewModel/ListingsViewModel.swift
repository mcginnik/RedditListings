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
    
    var fullURL: String {
        var url = baseURL + endPoint + "?\(RedditEndpoints.pagingLimitToken)\(pagingSize)"
        if let lastID = listings.last?.id {
            url += "&\(RedditEndpoints.pagingCursorToken)\(lastID)"
        }
        return url
    }
    
    let pagingSize: Int
    
    var cellHeight: CGFloat {
        80
    }
    
    @Published var listings: [ListingViewModel] = []
    
    // MARK: Lifecycle
    
    init(withEndpoint endPoint: String, pagingSize: Int = 20){
        self.endPoint = endPoint
        self.pagingSize = pagingSize
    }
    
    // MARK: API
    
    func fetchNextPage(){
        
        ListingsService.shared.fetchPage(from: fullURL) { [weak self] res in
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
