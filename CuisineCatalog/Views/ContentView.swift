//
//  ContentView.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/6/25.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: RecipeListViewModel
    @State private var shouldDisplaySheet: Bool = false
    @State private var selectedRecipe: Recipe? = nil
    @State private var sortSelection: SortingOption = .name
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading == true {
                    ProgressView()
                } else {
                    RecipeListView(viewModel: viewModel,
                                   selectedRecipe: $selectedRecipe,
                                   shouldDisplaySheet:
                                    $shouldDisplaySheet)
                }
            }
            .navigationTitle("Recipes")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.primaryBackground, for: .navigationBar)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    SortingView(viewModel: viewModel, sortSelection: $sortSelection)
                }
            })
        }
        .sheet(isPresented: Binding(
            get: { shouldDisplaySheet },
            set: { shouldDisplaySheet = $0} )
        ) {
            if let selectedRecipe {
                RecipeDetailView(recipe: selectedRecipe)
                    .presentationDetents([.medium])
            }
        }
        .task {
            do {
                try await viewModel.fetchRecipes()
            } catch {
                print("Error fetching recipes: \(error)")
            }
        }
    }
}
