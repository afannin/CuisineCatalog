//
//  CacheManager.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/8/25.
//

import SwiftUI

final class CacheManager {
    private let cacheUrl: URL
    
    init?() {
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        self.cacheUrl = cacheDir.appendingPathComponent("com.cuisineCatalog.imagecache")
        
        guard FileManager.default.fileExists(atPath: cacheUrl.path()) else {
            try? FileManager.default.createDirectory(at: cacheUrl, withIntermediateDirectories: true)
            return
        }
    }
    
    func fetchImage(from url: URL) async -> UIImage? {
        let imageUrl = cacheUrl.appendingPathComponent(createCacheName(from: url))
                    
        guard let data = try? Data(contentsOf: imageUrl),
            let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
    
    func cache(image: UIImage, with url: URL) async {
        let destinationUrl = cacheUrl.appendingPathComponent(createCacheName(from: url))
        
        if let data = image.jpegData(compressionQuality: 1) {
            do {
                try data.write(to: destinationUrl)
            } catch {
                print("Failed to cache image due to error: \(error)")
            }
        }
    }
    
    private func createCacheName(from url: URL) -> String {
        return url.pathComponents.joined()
    }
}
