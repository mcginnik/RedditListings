//
//  ListViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/24/23.
//

import UIKit

class ListViewModel<CD: ListCellDataProtocol>: ObservableObject {
    
    // MARK: Properties
    
    let baseURL: String = AppConfig.shared.baseURLString
    
    var fullURL: String {
        ""
    }
    
    var pagingSize: Int
    
    @Published var data: [CD] = []
    
    var idSet: Set<String> = []
    
    var fetchPageFromURL: (String, @escaping (Result<[CD.P], Error>) -> Void) -> Void = { _,_  in }
    
    // MARK: Lifecycle
    
    required init(pagingSize: Int){
        self.pagingSize = pagingSize
    }
    
    // MARK: API

    func fetchNextPage(){
        fetchPageFromURL{ [weak self] res in
            guard let strongSelf = self else { return }
            switch res {
            case .success(let pages):
                for item in pages.flatMap({$0.items}) {
                    if !strongSelf.idSet.contains(item.id), item.author != nil {
                        strongSelf.data.append(CD(withData: item))
                        strongSelf.idSet.insert(item.id)
                    } else {
                        Logging.LogMe("Skipping!  Alraady Exists.")
                    }
                }
            case .failure(let error):
                Logging.LogMe("... FAILED! \(error)")
            }
        }
    }
    
    private func fetchPageFromURL(completion: @escaping (Result<[CD.P], Error>) -> Void ){
        fetchPageFromURL(fullURL, completion)
    }
    
    // MARK: Helpers
    
    func cellHeight(forIndexPath indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
