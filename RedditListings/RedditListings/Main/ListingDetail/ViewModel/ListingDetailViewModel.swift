//
//  ListingDetailViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import Foundation
import Combine
import SwiftUI

class ListingDetailViewModel: ObservableObject {
    
    // MARK: Properties
    
    let baseURL: String = AppConfig.shared.baseURLString
    
    var fullURL: String {
        Endpoints.createCommentURLString(listingID: listingViewModel.id,
                                         pagingSize: pagingSize,
                                         cursor: viewModels.last?.id)
    }
    
    let pagingSize: Int
    
    @Published var viewModels: [CommentViewModel] = []
    @ObservedObject var listingViewModel: ListingViewModel
    
    // MARK: Lifecycle
    
    init(listingViewModel: ListingViewModel, pagingSize: Int = 20){
        self.listingViewModel = listingViewModel
        self.pagingSize = pagingSize
    }
    
    // MARK: API
    
    func fetchNextPage(){
        ListingDetailService.shared.fetchPage(from: fullURL) { [weak self] res in
            guard let strongSelf = self else { return }
            switch res {
            case .success(let pages):
                for item in pages.flatMap({$0.items}) {
                    if let _ = strongSelf.viewModels.first(where: {$0.id == item.id }) {
                        continue
                    }
                    strongSelf.viewModels.append(CommentViewModel(withData: item))
                }
                Logging.LogMe("... Success! \(pages)")
                
            case .failure(let error):
                Logging.LogMe("... FAILED! \(error)")
            }
        }
    }
    
    func cellHeight(forIndexPath indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 200
        if indexPath.item == 0 {
            return height * 1.5
        }
        return height
    }
    
}
