//
//  RecipeListItem.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/6/25.
//

import SwiftUI

struct RecipeListItemView: View {
    @State var recipe: Recipe
    typealias Constants = ViewConstants.ItemView
    
    var body: some View {
        HStack(alignment: .center) {
            CachedAsyncImage(url: recipe.photoUrlSmall) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image(systemName: "photo")
                    .background(Color.secondaryBackground)
            }
            .frame(width: Constants.imageSize, height: Constants.imageSize)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                HStack(spacing: 0) {
                    Text(recipe.name)
                        .foregroundStyle(.primaryText)
                        .font(.headline)
                        .lineLimit(Constants.lineLimit)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    
                    Text(Recipe.getFlagEmoji(for: recipe.cuisine))
                }
                .padding(.top, Constants.titleTopPadding)
                .padding(.bottom, Constants.defaultSpacing)
                                
                Text(recipe.cuisine)
                    .foregroundStyle(.secondaryText)
                    .font(.caption)
                
                Spacer()
                    .frame(maxHeight: .infinity)
            }
        }
        .contentShape(Rectangle())
    }
}
