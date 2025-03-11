//
//  RecipeListView.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/7/25.
//

import SwiftUI

struct RecipeListView: View {
    @State var viewModel: RecipeListViewModel
    @State var searchText: String = ""
    @State private var shouldDisplayListError: Bool = false
    
    @Binding var selectedRecipe: Recipe?
    @Binding var shouldDisplaySheet: Bool
    
    private var isSearching: Bool {
        !searchText.isEmpty
    }
    
    var body: some View {
        List {
            if isSearching {
                if viewModel.searchResults.count > 0 {
                    ForEach(viewModel.searchResults, id: \.id) { recipe in
                        RecipeListItemView(recipe: recipe)
                            .onTapGesture {
                                shouldDisplaySheet = true
                                selectedRecipe = recipe
                            }
                            .listRowBackground(Color.secondaryBackground)
                    }
                }
            } else {
                if let recipes = viewModel.recipes {
                    ForEach(recipes, id: \.id) { recipe in
                        RecipeListItemView(recipe: recipe)
                            .onTapGesture {
                                shouldDisplaySheet = true
                                selectedRecipe = recipe
                            }
                            .listRowBackground(Color.secondaryBackground)
                    }
                }
            }
        }
        .refreshable {
            Task {
                do {
                    try await viewModel.fetchRecipes()
                } catch {
                    print("Failed to fetch recipes: \(error)")
                }
            }
        }
        .overlay {
            if isSearching && viewModel.searchResults.isEmpty {
                ContentUnavailableView.search
                    .background(.clear)
            }
            
            if !viewModel.isLoading && !viewModel.hasRecipes {
                ContentUnavailableView {
                    Label("Couldn't load recipes", systemImage: "exclamationmark.warninglight")
                }
                actions: {
                    Button("Please try again") {
                        Task {
                            do {
                                try await viewModel.fetchRecipes()
                            } catch {
                                print("Failed to fetch recipes: \(error)")
                            }
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(colors: [.primaryBackground, .secondaryBackground],
                           startPoint: .top,
                           endPoint: .bottom)
        )
        .searchable(text: $searchText)
        .onChange(of: searchText) {
            viewModel.filterRecipes(by: searchText)
        }
    }
}
