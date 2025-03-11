//
//  Recipe+FlagTests.swift
//  CuisineCatalogTests
//
//  Created by Andrew Fannin on 3/7/25.
//

import XCTest
@testable import CuisineCatalog

final class RecipeFlagTests: XCTestCase {
    func testGetFlagEmoji() async throws {
        XCTAssertEqual(Recipe.getFlagEmoji(for: "American"), "🇺🇸")
        XCTAssertEqual(Recipe.getFlagEmoji(for: "British"), "🇬🇧")
        XCTAssertEqual(Recipe.getFlagEmoji(for: "Party Island"), "🏳️")
    }
}

