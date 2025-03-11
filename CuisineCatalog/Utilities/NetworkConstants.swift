//
//  NetworkConstants.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/7/25.
//

import Foundation

struct NetworkConstants {
    // Recipe Endpoint
    static let baseUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")

    // Testing Endpoints
    static let malformedUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
    static let emptyURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
    
    static let successCodeRange = (200..<300)
}
