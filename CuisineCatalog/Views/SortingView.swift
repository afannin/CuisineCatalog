//
//  SortingView.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/8/25.
//

import SwiftUI

struct SortingView: View {
    @State var viewModel: RecipeListViewModel
    @Binding var sortSelection: SortingOption
    
    var body: some View {
        HStack(spacing: 0) {
            Text("Sort by")
                .foregroundStyle(.primaryText)
            
            Menu(sortSelection.rawValue.capitalized) {
                ForEach(SortingOption.allCases, id: \.self) { option in
                    Button(action: {
                        sortSelection = option
                        viewModel.sortRecipes(by: sortSelection)
                    }) {
                        Text(option.rawValue.capitalized)
                    }
                    .disabled(viewModel.isLoading)
                }
            }
        }
    }
}

