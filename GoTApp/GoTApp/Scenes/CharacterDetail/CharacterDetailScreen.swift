//
//  CharacterDetailScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 31.07.2023.
//

import SwiftUI

struct CharacterDetailScreen: View {
    let character: CharacterResponse
    let padding: CGFloat = 16.0 // Define the padding value here

    var body: some View {
        ZStack {
            ScrollView{

            VStack {
                TextSection(title: "Character Name", content: character.name)
                    .padding(.top, padding * 2)
                    .padding(.bottom, padding)

                TextSection(title: "Gender", content: character.gender)
                    .padding(.top, padding)
                    .padding(.bottom, padding)
                
                if !character.culture.isEmpty{
                    TextSection(title: "Culture", content: character.culture)
                        .padding(.top, padding)
                        .padding(.bottom, padding)
                }
                

                if character.tvSeries != [] {
                    
                    TextSection(title: "TV Series", content: "Season List")
                        .padding(.top, padding)

                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.fixed(50))], spacing: padding) {
                            ForEach(character.tvSeries, id: \.self) { chapter in
                                    Text(chapter)
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                        .foregroundColor(Color("GoTWhite"))
                                        .frame(width: 200, height: 100)
                                        .cornerRadius(8)
                                        .background(Color("GoTDarkGray"))
                                }
                        }
                        .padding(.horizontal, padding)
                        .padding(.top, padding)
                    }
                }

                if character.titles.count != 0 {
                    
                    TextSection(title: "Titles", content: "Character Title List")
                        .padding(.top, padding)

                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.fixed(50))], spacing: padding) {
                            ForEach(character.titles, id: \.self) { title in
                                    Text(title)
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                        .foregroundColor(Color("GoTWhite"))
                                        .frame(width: 200, height: 100)
                                        .cornerRadius(8)
                                        .background(Color("GoTDarkGray"))
                                }
                        }
                        .padding(.horizontal, padding)
                        .padding(.top, padding)
                    }
                }
            }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("GoTWhite"), Color("GoTDarkGray")]), startPoint: .top, endPoint: .bottom))
    }
}
