//
//  MockService.swift
//  GoTApp
//
//  Created by Sena Kurtak on 1.05.2024.
//

import Foundation

struct MockService {
    static func mockHousesData() -> Data {
        let houses = [
            HouseResponse(url: "https://example.com/house1", name: "House Stark", region: "North", coatOfArms: "A running wolf", overlord: "Eddard Stark"),
            HouseResponse(url: "https://example.com/house2", name: "House Lannister", region: "West", coatOfArms: "A roaring lion", overlord: "Tywin Lannister")
        ]

        return try! JSONEncoder().encode(houses)
    }

    static func mockErrorData() -> Data {
        return Data()
    }
}
