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
    var padding: CGFloat = 10
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Region")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: UIScreen.main.bounds.width - padding, height: 50, alignment: .leading)
                    Text("\(house.region)")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .frame(width: UIScreen.main.bounds.width - padding, height: 50, alignment: .leading)
                    if house.coatOfArms != "" {
                        Text("Coat of Arms")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(width: UIScreen.main.bounds.width - padding, height: 50, alignment: .leading)
                        Text("\(house.coatOfArms)")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(width: UIScreen.main.bounds.width - padding, alignment: .leading)
                    }
                    Text("Overlord Info")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: UIScreen.main.bounds.width - padding, height: 50, alignment: .leading)
                    
                    if let overlord = viewModel.overlord {
                        Text("Name: \(overlord.name)")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(width: UIScreen.main.bounds.width - padding, alignment: .leading)
                    } else {
                        Text("Loading Overlord Info...")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(width: UIScreen.main.bounds.width - padding, alignment: .leading)
                    }
                    if !viewModel.characterNames.isEmpty {
                        Text("Sworn Members")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        
                            .frame(width: UIScreen.main.bounds.width - padding, alignment: .leading)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem(.fixed(50))], spacing: 16) {
                                ForEach(viewModel.characterNames, id: \.self) { characterName in
                                    Text(characterName)
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                        .foregroundColor(Color("GoTWhite"))
                                    
                                }
                                .cornerRadius(8)
                                .frame(width: 200, height: 250)
                                .background(Color("GoTDarkGray"))
                                
                            }
                            .padding(.horizontal, padding)
                        }
                    } else {
                        Text("No sworn members available.")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(width: UIScreen.main.bounds.width - padding, alignment: .leading)
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("GoTWhite"), Color("GoTDarkGray")]), startPoint: .top, endPoint: .bottom))
            .onAppear {
                viewModel.fetchOverlord()
                viewModel.fetchCharacter()
            }
            .onReceive(viewModel.$overlord) { overlord in
            }
        }
        .navigationTitle(house.name)
    }
}
