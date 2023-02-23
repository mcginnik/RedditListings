//
//  ImageService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import UIKit

enum ImageServiceError: Error {
    case fetch
    case invalidURL
}

class ImageService {
    
    static let shared: ImageService = ImageService()
    
    var cache: NSCache<NSString, AnyObject> = {
        let c = NSCache<NSString, AnyObject>()
        c.countLimit = 0
        let byt = 1
        let kb = 1024 * byt
        let mb = kb * 1024
        c.totalCostLimit = 50 * mb // 50 megabytes
        return c
    }()
    
    private init(){}
    
    func fetchImage(_ URLString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let nsURLString = NSString(string: URLString)
        if let image = cache.object(forKey: nsURLString) as? UIImage {
            Logging.LogMe("Fetched from cache \(URLString)")
            completion(.success(image))
            return
        }
        
        guard URLString.isValid(regex: .url) else  {
            Logging.LogMe("Invalid URL \(URLString)")
            completion(.failure(ImageServiceError.invalidURL))
            return
        }
        
        let formattedURLString = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: formattedURLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    completion(.failure(ImageServiceError.fetch))
                    return
                }
                DispatchQueue.main.async { [ weak self ] in
                    if let data = data, let image = UIImage(data: data) {
                        self?.cache.setObject(image, forKey: nsURLString)
                        completion(.success(image))
                    }
                }
            }).resume()
        }
    }
    
}
