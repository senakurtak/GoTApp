//
//  DetailScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import SwiftUI

struct DetailScreen: View {
    
    // MARK: Properties
    
    let house: HouseResponse
    @StateObject var viewModel: DetailScreenViewModel
    var padding: CGFloat = 20
    
    // MARK: UI Elements
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
            }
            .frame(width: UIScreen.main.bounds.width - padding, height: UIScreen.main.bounds.height - 50, alignment: .top)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("GoTWhite"), Color("GoTDarkGray")]), startPoint: .top, endPoint: .bottom))
        .onAppear {
            viewModel.fetchOverlord()
            viewModel.fetchCharacter()
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
}
