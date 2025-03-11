//
//  NetworkManagerTests.swift
//  CuisineCatalogTests
//
//  Created by Andrew Fannin on 3/8/25.
//

import XCTest
@testable import CuisineCatalog

final class NetworkManagerTests: XCTestCase {
    private var networkMock = NetworkMock()
    
    private func fetchJSON() async throws -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "recipes", ofType: "json") else {
            XCTFail("Invalid path to JSON")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            return data
        } catch {
            XCTFail("Could not parse JSON")
            
            return nil
        }
    }
    
    func testGetSuccess() async throws {
        networkMock.mockData = try await fetchJSON()
        
        let recipes: [String: [Recipe]] = try await networkMock.get(NetworkConstants.emptyURL!)

        guard let recipe = recipes["recipes"]?.first else {
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
    
    func testGetFailure() async throws {
        networkMock.mockError = URLError(.badServerResponse)
            
        do {
            let _: [String: [Recipe]] = try await networkMock.get(NetworkConstants.emptyURL!)
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }
}
