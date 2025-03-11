//
//  CacheManagerTests.swift
//  CuisineCatalogTests
//
//  Created by Andrew Fannin on 3/8/25.
//

import XCTest
@testable import CuisineCatalog

final class CacheManagerTests: XCTestCase {
    private let cacheManager = CacheManager()
    
    func testImageCaching() async {
        let negativeURL = URL(string: "definitely-not-an-image")!
        
        guard let imagePath = Bundle(for: type(of: self)).path(forResource: "small", ofType: ".jpg") else {
            XCTFail("Could not find image file")
            return
        }

        let testURL = URL(string: imagePath)!

        guard let image = UIImage(contentsOfFile: imagePath),
            let cacheManager else {
            XCTFail("Could not create image from path \(imagePath)")
            return
        }
        
        await cacheManager.cache(image: image, with: testURL)
        let cachedImage = await cacheManager.fetchImage(from: testURL)
        XCTAssertNotNil(cachedImage)
        
        let noImage = await cacheManager.fetchImage(from: negativeURL)
        XCTAssertNil(noImage)
    }
}
