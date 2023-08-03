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
        ZStack{
            NavigationView {
                if favoriteHouses.isEmpty {
                    ZStack{
                        Text("There is no favorite home to be displayed")
                            .font(.headline)
                            .foregroundColor(Color.gray)
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .foregroundColor(Color.gray.opacity(0.3))
                    }
                } else {
                    List {
                        ForEach(favoriteHouses) { house in
                            NavigationLink(destination: DetailScreen(house: house, viewModel: DetailScreenViewModel(house: house)).navigationBarBackButtonHidden(true)) {
                                Text(house.name)
                                    .font(.headline)
                            }
                        }
                    }
                    .navigationTitle("Favorite Houses")
                }
            }
            .onAppear {
                favoriteHouses = FavoritesManager.shared.favoriteHouses
            }
        }
    }
}
