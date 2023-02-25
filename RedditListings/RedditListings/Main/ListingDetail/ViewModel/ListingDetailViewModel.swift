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
    
    var idSet: Set<String> = []
    
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
                    if !strongSelf.idSet.contains(item.id) {
                        strongSelf.viewModels.append(CommentViewModel(withData: item))
                        strongSelf.idSet.insert(item.id)
                    } else {
                        Logging.LogMe("Skipping!  Alraady Exists.")
                    }
                }
                Logging.LogMe("... Success! pages \(pages)")
                
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
