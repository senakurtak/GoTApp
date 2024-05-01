//
//  MockNetworkManager.swift
//  GoTApp
//
//  Created by Sena Kurtak on 1.05.2024.
//

import Foundation

final class MockNetworkManager: NetworkManagerProtocol {
    var shouldReturnError: Bool
    var testData: Data

    init(testData: Data, shouldReturnError: Bool = false) {
        self.testData = testData
        self.shouldReturnError = shouldReturnError
    }

    func fetchData<T>(from url: String) async throws -> T where T: Decodable {
        if shouldReturnError {
            throw NetworkError.httpError(0)
        }

        return try JSONDecoder().decode(T.self, from: testData)
    }
}
