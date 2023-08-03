//
//  FavoritesManager.swift
//  GoTApp
//
//  Created by Sena Kurtak on 3.08.2023.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()

    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "FavoriteHouses"

    var favoriteHouses: [HouseResponse] {
        get {
            if let data = userDefaults.data(forKey: favoritesKey),
               let favoriteHouses = try? JSONDecoder().decode([HouseResponse].self, from: data) {
                return favoriteHouses
            } else {
                return []
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaults.set(data, forKey: favoritesKey)
            }
        }
    }
    private init() {}

    func isHouseFavorite(_ name: String) -> Bool {
        return favoriteHouses.contains { $0.name == name }
    }

    func toggleFavoriteHouse(_ house: HouseResponse) {
        if isHouseFavorite(house.name) {
            favoriteHouses.removeAll { $0.name == house.name }
        } else {
            favoriteHouses.append(house)
            saveFavoriteHouses()
        }
    }

    private func saveFavoriteHouses() {
        if let data = try? JSONEncoder().encode(favoriteHouses) {
            userDefaults.set(data, forKey: favoritesKey)
        }
    }
}
