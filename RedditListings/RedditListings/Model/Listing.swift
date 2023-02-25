//
//  Listing.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

struct ListingPage : Decodable {
    let kind: String
    let data: ItemList<Listing>
    
    var items: [Listing] {
        return data.children.map { $0.data }
    }
}

struct Listing: ItemProtocol, Equatable, Hashable {
    let id: String
    var title: String?
    var author: String?
    var subtitle: String?
    var body: String?
    var thumbnail: String?
    var url: String?
    let createdAt: Double
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? values.decode(String.self, forKey: .id)) ?? "NOID"
        self.title = try? values.decode(String.self, forKey: .title)
        self.author = try? values.decode(String.self, forKey: .author)
        self.subtitle = try? values.decode(String.self, forKey: .subtitle)
        self.body = try? values.decode(String.self, forKey: .body)
        self.thumbnail = try? values.decode(String.self, forKey: .thumbnail)
        self.url = try? values.decode(String.self, forKey: .url)
        
        let createdAt = (try? values.decode(String.self, forKey: .created_utc)) ?? ""
        self.createdAt = Double(createdAt) ?? Date.now.timeIntervalSince1970
    }
}

extension Listing: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case subtitle
        case body
        case thumbnail
        case url
        case created_utc
    }
    
}
