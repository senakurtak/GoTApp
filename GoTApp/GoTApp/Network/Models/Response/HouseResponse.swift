//
//  HouseResponse.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import Foundation
struct HouseResponse: Hashable, Decodable, Identifiable {
    let id = UUID()
    let url: String
    let name: String
    let region: String
    let coatOfArms: String
    let overlord: String  
}
