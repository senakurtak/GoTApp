//
//  FavoritesManager.swift
//  GoTApp
//
//  Created by Sena Kurtak on 3.08.2023.
//

import Foundation

final class FavoritesManager {
    
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
    
    func isHouseFavorite(_ houseId: UUID) -> Bool {
        return favoriteHouses.contains(where: { $0.id == houseId })
    }
    
    func toggleFavoriteHouse(_ house: HouseResponse) {
        if let index = favoriteHouses.firstIndex(where: { $0.id == house.id }) {
            favoriteHouses.remove(at: index)
        } else {
            favoriteHouses.append(house)
        }
    }
}
