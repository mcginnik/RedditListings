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
    
    var cellHeight: CGFloat {
        80
    }
    
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
            switch res {
            case .success(let pages):
                for page in pages {
                    self?.viewModels.append(contentsOf: page.items.compactMap{CommentViewModel(withData: $0)})
                }
                Logging.LogMe("... Success! \(pages)")
                
            case .failure(let error):
                Logging.LogMe("... FAILED! \(error)")
            }
        }
    }
    
}


//import Foundation
//import Combine
//import SwiftUI
//
//class ListViewModel<VM>: ObservableObject {
//    
//    // MARK: Properties
//    
//    var baseURL: String { AppConfig.shared.baseURLString }
//    
//    
//    /// Override in Subclass
//    var fullURL: String {
//        baseURL
//    }
//    
//    let pagingSize: Int
//    
//    /// Override in Subclass
//    var cellHeight: CGFloat {
//        80
//    }
//    
//    @Published var viewModels: [VM] = []
//    
//    // MARK: Lifecycle
//    
//    init(pagingSize: Int = 20){
//        self.pagingSize = pagingSize
//    }
//    
//    // MARK: API
//    
//    func fetchNextPage(){
//        ListingDetailService.shared.fetchPage(from: fullURL) { [weak self] res in
//            switch res {
//            case .success(let pages):
//                for page in pages {
//                    self?.viewModels.append(contentsOf: page.items.compactMap{CommentViewModel(withData: $0)})
//                }
//                Logging.LogMe("... Success! \(pages)")
//                
//            case .failure(let error):
//                Logging.LogMe("... FAILED! \(error)")
//            }
//        }
//    }
//    
//}
