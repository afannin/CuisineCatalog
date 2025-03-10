//
//  CachedAsyncImage.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/8/25.
//

import SwiftUI

struct CachedAsyncImage<ImageView: View, PlaceholderView: View>: View {
    private let cacheManager = CacheManager()
    var url: URL?
    
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> PlaceholderView
    
    @State var image: UIImage? = nil
    
    init(url: URL?,
         @ViewBuilder content: @escaping (Image) -> ImageView,
         @ViewBuilder placeholder: @escaping () -> PlaceholderView
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        if let image {
            content(Image(uiImage: image))
        } else {
            placeholder()
                .task {
                    await loadImage()
                }
        }
    }
    
    private func loadImage() async {
        guard let url else {
            return
        }
        
        guard let cachedImage = await cacheManager?.fetchImage(from: url) else {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                if let downloadedImage = UIImage(data: data) {
                    await cacheManager?.cache(image: downloadedImage, with: url)
                    image = downloadedImage
                }
            } catch {
                print("Loading image failed with \(error)")
            }
            
            return
        }
        
        image = cachedImage
    }
}

