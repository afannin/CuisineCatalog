//
//  Recipe.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/6/25.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    let cuisine: String
    let name: String
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let id: String
    let sourceUrl: URL?
    let youtubeUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case id = "uuid"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}
