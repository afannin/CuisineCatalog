//
//  RecipeDetailView.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/7/25.
//

import SwiftUI

struct RecipeDetailView: View {
    @State var recipe: Recipe
    typealias Constants = ViewConstants.DetailView
    
    var body: some View {
        VStack(spacing: Constants.defaultSpacing) {
            HStack {
                Text(recipe.name)
                    .foregroundStyle(.primaryText)
                    .font(.title2)
                
                Spacer()
                
                Text(Recipe.getFlagEmoji(for: recipe.cuisine))
            }
            .padding(.top, Constants.defaultPadding)
            .padding(.horizontal, Constants.defaultPadding)
            .padding(.bottom, Constants.defaultSpacing)
            
            CachedAsyncImage(url: recipe.photoUrlLarge) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
                    .scaledToFill()
                    .padding(Constants.defaultPadding)
                    .frame(height: Constants.imagePlaceholderHeight)
            }
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            
            if let sourceUrl = recipe.sourceUrl {
                Link("View Full Recipe", destination: sourceUrl)
                    .font(.callout)
            }
            
            if let videoUrl = recipe.youtubeUrl {
                Link("See How it's Made! ▶️", destination: videoUrl)
                    .font(.callout)
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea([.top, .horizontal])
        .background(.primaryBackground.gradient)
    }
}
