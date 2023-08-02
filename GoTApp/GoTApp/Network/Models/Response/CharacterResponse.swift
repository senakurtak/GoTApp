//
//  CharacterResponse.swift
//  GoTApp
//
//  Created by Sena Kurtak on 31.07.2023.
//

import Foundation

struct CharacterResponse: Codable, Hashable {
    let url: String
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let titles, aliases: [String]
    let father, mother: String
    let spouse: String
    let allegiances, books: [String]
    let tvSeries, playedBy: [String]
}
