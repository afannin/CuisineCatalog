//
//  RecipeListViewModel.swift
//  CuisineCatalogTests
//
//  Created by Andrew Fannin on 3/8/25.
//

import XCTest
@testable import CuisineCatalog

final class RecipeListViewModelTests: XCTestCase {
    private var networkMock = NetworkMock()
    private var viewModel: RecipeListViewModel!
    
    override func setUp() async throws {
        try await super.setUp()

        viewModel = RecipeListViewModel(networkManager: networkMock)
        networkMock.mockData = try await fetchJSON()
        try await viewModel.fetchRecipes()
    }
    
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
