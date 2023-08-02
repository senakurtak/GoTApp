//
//  DetailScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import SwiftUI

struct DetailScreen: View {
    let house: HouseResponse
    @StateObject var viewModel: DetailScreenViewModel
    
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                TextSection(title: "Region", content: house.region)
                    .padding(.top, padding)
                    .padding(.bottom, padding)
                
                if house.coatOfArms != "" {
                    TextSection(title: "Coat of Arms", content: house.coatOfArms)
                        .padding(.top, padding)
                        .padding(.bottom, padding)
                }
                
                if let overlord = viewModel.overlord {
                    TextSection(title: "Overlord", content: overlord.name)
                        .padding(.top, padding)
                        .padding(.bottom, padding)
                } else {
                    TextSection(title: "Loading Overlord Info...", content: "")
                }
                
                if !viewModel.characters.isEmpty {
                    Text("Sworn Members")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: UIScreen.main.bounds.width - padding, alignment: .bottomLeading)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.fixed(50))], spacing: padding) {
                            ForEach(viewModel.characters, id: \.self) { character in
                                NavigationLink(destination: CharacterDetailScreen(character: character)) {
                                    Text(character.name)
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                        .foregroundColor(Color("GoTWhite"))
                                        .frame(width: 200, height: 250)
                                        .cornerRadius(8)
                                        .background(Color("GoTDarkGray"))
                                }
                            }
                        }
                        .padding(.horizontal, padding)
                        .padding(.top, padding)
                    }
                } else {
                    Text("No sworn members available.")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .frame(width: UIScreen.main.bounds.width - padding, alignment: .leading)
                }
                
                Button(action: {
                    isFavorite = FavoritesManager.shared.isHouseFavorite(house.name)
                    toggleFavorite()
                    if isFavorite {
                        Text("Remove from Favorites")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(8)
                    } else {
                        Text("Add to Favorites")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }) {
                    if isFavorite {
                        Text("Remove from Favorites")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(8)
                    } else {
                        Text("Add to Favorites")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }
                .padding(.top, padding)
            }
        }
        .onAppear {
            viewModel.house = house
            viewModel.fetchOverlord()
            viewModel.fetchCharacter()
            updateFavoriteStatus()
        }
        .onReceive(viewModel.$overlord) { overlord in
            print(viewModel.characters)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(house.name)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color("GoTDarkGray"))
            }
        }
    }
    
    var padding: CGFloat = 20
    
    func updateFavoriteStatus() {
        isFavorite = FavoritesManager.shared.isHouseFavorite(house.name)
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
        FavoritesManager.shared.toggleFavoriteHouse(house)
    }
}
