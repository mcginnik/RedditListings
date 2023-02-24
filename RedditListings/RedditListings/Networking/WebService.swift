//
//  WebService.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

enum NetworkError: Error {
    case Decoding
    case Domain
    case URLFormatting
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .Decoding:
            return NSLocalizedString("Error Decoding Data...", comment: "No Data Returned because it may be badly formed...")
        case .Domain:
            return NSLocalizedString("Error Fetching Data... Bad Domain", comment: "Check the URL...")
        case .URLFormatting:
            return NSLocalizedString("Error Fetching Data... Badly formed URL...", comment: "Bad URL Format...")
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

struct Request< T: Decodable> {
    let url: URL
    var body: Data?
    var httpMethod: HttpMethod = .get
}

struct WebService {
    
    static func execute<T>(request: Request<T>, completion: @escaping (Result<T, Error>) -> Void) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpBody = request.body
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Logging.LogMe("...STARTING url \(request.url)")

        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.Domain))
                return
            }
            
            do {
                let dataDict = try? data.asDictionary()
                Logging.LogMe("... url \(request.url)")
                Logging.LogMe("... data \(dataDict ?? [:])")
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    
}

//
extension Data {
  func asDictionary() throws -> [String: Any] {
    guard let dictionary = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any] else {
        throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "IDK"))
    }
    return dictionary
  }
}
