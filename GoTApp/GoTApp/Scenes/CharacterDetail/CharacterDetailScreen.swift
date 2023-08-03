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
                    
                    
                    if character.tvSeries.first != "" || character.tvSeries != [""] {
                        TextSection(title: "TV Series", content: "")
                            .padding(.top, padding)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem(.fixed(50))], spacing: padding) {
                                ForEach(character.tvSeries, id: \.self) { chapter in
                                    if chapter != ""{
                                        Text(chapter)
                                            .font(.system(size: 18, weight: .medium, design: .default))
                                            .foregroundColor(Color("GoTWhite"))
                                            .frame(width: 200, height: 100)
                                            .cornerRadius(8)
                                            .background(Color("GoTDarkGray"))
                                            .padding(.horizontal, padding)
                                            .padding(.top, padding)
                                    }
                                }
                            }
                            .padding(.horizontal, padding)
                            .padding(.top, padding)
                        }
                    } else {
                        HStack{
                            Text("There is no TV Series to be listed")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color("GoTWhite"))
                                .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                                .cornerRadius(8)
                                .background(Color.red)
                                .padding(.leading, 10)
                        }


                    }
                    
                    if character.titles.first != "" || character.titles != [""] {
                        
                        TextSection(title: "Titles", content: "")
                            .padding(.top, padding)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem(.fixed(50))], spacing: padding) {
                                ForEach(character.titles, id: \.self) { title in
                                    
                                    if title != "" {
                                        Text(title)
                                            .font(.system(size: 18, weight: .medium, design: .default))
                                            .foregroundColor(Color("GoTWhite"))
                                            .frame(width: 200, height: 100)
                                            .cornerRadius(8)
                                            .background(Color("GoTDarkGray"))
                                            .padding(.horizontal, padding)
                                            .padding(.top, padding)

                                    }
                                    
                                }
                            }
                            .padding(.horizontal, padding)
                            .padding(.top, padding)
                        }
                    } else {
                        HStack{
                            Text("There is no Titles to be listed")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color("GoTWhite"))
                                .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                                .cornerRadius(8)
                                .background(Color.red)
                                .padding(.leading, 10)
                        }
                    }
                }
                .padding(.top, 100)
            }
        }
        .navigationTitle(character.name)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("GoTWhite"), Color("GoTDarkGray")]), startPoint: .top, endPoint: .bottom))
    }
}
