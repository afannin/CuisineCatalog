//
//  RecipeListViewModel.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/7/25.
//

import SwiftUI

enum SortingOption: String, CaseIterable {
    case name
    case cuisine
}

@Observable
final class RecipeListViewModel {
    var recipes: [Recipe]?
    var isLoading = false
    var searchResults: [Recipe] = []
    
    private var networkManager: NetworkManager
    
    var hasRecipes: Bool {
        guard let recipes else {
            return false
        }
        
        return !recipes.isEmpty
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchRecipes() async throws {
        isLoading = true
        
        do {
            if let url = NetworkConstants.baseUrl,
               let fetchedRecipes: [String: [Recipe]] = try await networkManager.get(url) {
                recipes = fetchedRecipes["recipes"]
            }
        } catch {
            switch error {
            case NetworkError.decodingError:
                print("Decoding error: \(error)")
            case NetworkError.responseError:
                print("Response error: \(error)")
            default:
                print("Unhandled error: \(error)")
            }
        }
        
        isLoading = false
    }
    
    func sortRecipes(by option: SortingOption) {
        guard hasRecipes else {
            return
        }
        
        switch option {
        case .cuisine:
            recipes = recipes?
                .sorted(by: { $0.cuisine < $1.cuisine } )
        case .name:
            recipes = recipes?
                .sorted(by: { $0.name < $1.name } )
        }
    }
    
    func filterRecipes(by searchText: String) {
        guard let recipes else {
            return
        }
        
        searchResults = recipes.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.cuisine.lowercased().contains(searchText.lowercased()) }
    }
}
