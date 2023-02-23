//
//  AppConfig.swift
//  RedditListings
//
//  Created by Kyle McGinnis on 2/22/23.
//

import Foundation

public class AppConfig {

    // MARK: - Properties

    static let shared: AppConfig = AppConfig()
    
    private (set) var loggingLevel: LoggingLevel = .medium
    
    private (set) var baseURLString = Endpoints.baseURL
    
    // MARK: - Lifecycle

    private init() {}
    
    // MARK: - API
    
    func setBaseURLString(to url: String){
        self.baseURLString = url
    }

}
