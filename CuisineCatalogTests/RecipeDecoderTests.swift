//
//  RecipeDecoderTests.swift
//  CuisineCatalogTests
//
//  Created by Andrew Fannin on 3/8/25.
//

import Foundation
@testable import CuisineCatalog
import XCTest

@MainActor
final class RecipeDecoderTests: XCTestCase {
    private var recipes: [Recipe]?
    
    override func setUp() async throws {
        try await super.setUp()
        recipes = try await fetchJSON()
    }
    
    private func fetchJSON() async throws -> [Recipe]? {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "malformedRecipes", ofType: "json") else {
            XCTFail("Invalid path to JSON")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            let recipes = try JSONDecoder().decode([String: [Recipe]].self, from: data)
            
            XCTAssertNotNil(recipes)
            
            return recipes["recipes"]
        } catch {
            XCTFail("Could not parse JSON")
            
            return nil
        }
    }
    
    func testDecoder() async throws {
        guard let recipe = recipes?.first else {
            XCTFail("Could not load first Recipe")
            return
        }
        
        XCTAssertEqual(recipe.cuisine, "Malaysian")
        XCTAssertEqual(recipe.name, "Apam Balik")
        XCTAssertEqual(recipe.photoUrlLarge, URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"))
        XCTAssertEqual(recipe.photoUrlSmall, URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"))
        XCTAssertEqual(recipe.sourceUrl, URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"))
        XCTAssertEqual(recipe.id, "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        XCTAssertEqual(recipe.youtubeUrl, URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg"))
    }
    
    func testMalformedDecoder() async throws {
        guard let recipe = recipes?[1] else {
            XCTFail("Could not load malformed Recipe")
            return
        }
        
        XCTAssertEqual(recipe.cuisine, "")
        XCTAssertEqual(recipe.name, "")
        XCTAssertEqual(recipe.photoUrlLarge, URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg"))
        XCTAssertEqual(recipe.photoUrlSmall, URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"))
        XCTAssertEqual(recipe.sourceUrl, URL(string: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble"))
        XCTAssertEqual(recipe.id, "599344f4-3c5c-4cca-b914-2210e3b3312f")
        XCTAssertEqual(recipe.youtubeUrl, URL(string: "https://www.youtube.com/watch?v=4vhcOwVBDO4"))
    }
}
