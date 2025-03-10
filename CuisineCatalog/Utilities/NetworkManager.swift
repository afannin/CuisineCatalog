//
//  NetworkManager.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/7/25.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case responseError
}

protocol NetworkClient {
    func get<T: Decodable>(_ url: URL) async throws -> T
}

final class NetworkManager: NetworkClient {
    func get<T: Decodable>(_ url: URL) async throws -> T where T : Decodable {
        let result: T
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            result = try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
        
        if let responseCode = result as? HTTPURLResponse,
            !(200...299).contains(responseCode.statusCode) {
            throw NetworkError.responseError
        }
        
        return result
    }
}
