//
//  Overloard.swift
//  GoTApp
//
//  Created by Sena Kurtak on 29.07.2023.
//

import Foundation

struct OverlordResponse: Hashable, Decodable, Identifiable {
    let id = UUID()
    let url: String
    let name: String
    let region: String
    let coatOfArms: String
    let words: String
    let titles, seats: [String]
    let currentLord: String
    let heir: String
    let overlord: String
    let founded: String
    let founder: String
    let diedOut: String
    let ancestralWeapons: [String]
    let cadetBranches: [String]
    let swornMembers: [String]
}
