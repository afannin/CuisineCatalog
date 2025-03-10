//
//  RecipeListViewModel.swift
//  CuisineCatalogTests
//
//  Created by Andrew Fannin on 3/8/25.
//

import XCTest
@testable import CuisineCatalog

final class RecipeListViewModelTests: XCTestCase {
    
    private var recipes: [Recipe]?
    let viewModel = RecipeListViewModel(networkManager: NetworkManager())
    
    override func setUp() async throws {
        try await super.setUp()
        viewModel.recipes = try await fetchJSON()
    }
    
    private func fetchJSON() async throws -> [Recipe]? {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "recipes", ofType: "json") else {
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
    
    func testSortRecipes() {
        var option = SortingOption.cuisine
        
        viewModel.sortRecipes(by: option)
        XCTAssertEqual(viewModel.recipes?.first?.cuisine, "American")
        
        option = SortingOption.name
        viewModel.sortRecipes(by: option)
        XCTAssertEqual(viewModel.recipes?.first?.cuisine, "Malaysian")
    }
    
    func testFilterRecipes() {
        viewModel.filterRecipes(by: "anad")
        XCTAssertEqual(viewModel.searchResults.count, 5)
        
        viewModel.filterRecipes(by: "aoeuaoeuoea")
        XCTAssertEqual(viewModel.searchResults.count, 0)
        
        viewModel.filterRecipes(by: "LIME p")
        XCTAssertEqual(viewModel.searchResults.count, 1)
    }
}
