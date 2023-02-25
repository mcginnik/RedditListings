//
//  PostViewModel.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit
import Combine

class PostViewModel: ItemViewModel<Post> {}

extension PostViewModel: ListCellDataProtocol {
    typealias P = PostPage
}
