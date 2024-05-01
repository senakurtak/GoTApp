//
//  GoTAppTests.swift
//  GoTAppTests
//
//  Created by Sena Kurtak on 1.05.2024.
//

import XCTest

final class GoTAppTests: XCTestCase {
    var viewModel: HomeScreenViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        let testData = MockService.mockHousesData()
        mockNetworkManager = MockNetworkManager(testData: testData)
        viewModel = HomeScreenViewModel(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchHousesSuccess() async {
        await viewModel.fetchAllHouses()
        XCTAssertEqual(viewModel.houses.count, 2, "Should have fetched 2 houses")
    }

    func testFetchHousesFailure() async {
        mockNetworkManager.shouldReturnError = true
        await viewModel.fetchAllHouses()
        XCTAssertTrue(viewModel.houses.isEmpty, "Houses should be empty on fetch failure")
    }
}
