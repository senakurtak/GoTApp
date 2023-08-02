//
//  FavoriteHousesScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 2.08.2023.
//
import SwiftUI

struct FavoriteHousesScreen: View {
    @State private var favoriteHouses: [HouseResponse] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteHouses) { house in
                    NavigationLink(destination: DetailScreen(house: house, viewModel: DetailScreenViewModel(house: house))) {
                        Text(house.name)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Favorite Houses")
        }
        .onAppear {
            favoriteHouses = FavoritesManager.shared.favoriteHouses
        }
    }
}
