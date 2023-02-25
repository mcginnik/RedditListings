//
//  SectionCellData.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/23/23.
//

import UIKit

protocol ListCellDataProtocol {
    var id: String { get }
    var title: String { get }
    var subtitle: String? { get }
    var body: String? { get }
    var caption: String { get }
    var imageURL: String? { get }
    func fetchImage(completion: @escaping (Result<(UIImage, String), Error>) -> Void)
}

extension ListCellDataProtocol {
    
    func fetchImage(completion: @escaping (Result<(UIImage, String), Error>) -> Void){
        guard let imageURL = imageURL else {
            let error = ImageServiceError.invalidURL
            completion(.failure(error))
//            Logging.LogMe("Failed! \(error)")
            return
        }
        ImageService.shared.fetchImage(imageURL) { res in
            DispatchQueue.main.async {
                switch res {
                case .success(let image):
                    completion(.success((image, imageURL)))
//                    Logging.LogMe("Success! \(imageURL)")
                case .failure(let error):
                    completion(.failure(error))
//                    Logging.LogMe("Failed! \(error)")
                }
            }
        }
    }

}
