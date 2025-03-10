//
//  NetworkMock.swift
//  CuisineCatalogTests
//
//  Created by Andrew Fannin on 3/8/25.
//

import XCTest
@testable import CuisineCatalog

final class NetworkMock: XCTestCase, NetworkClient {
    var mockData: Data?
    var mockError: Error?
    
    func get<T>(_ url: URL) async throws -> T where T : Decodable {
        if let error = mockError {
            throw error
        }
        
        guard let mockData else {
            throw URLError(.cannotLoadFromNetwork)
        }
        
        return try JSONDecoder().decode(T.self, from: mockData)
    }
}
