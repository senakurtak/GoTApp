//
//  Endpoint.swift
//  GoTApp
//
//  Created by Sena Kurtak on 26.07.2023.
//

import Foundation

public enum Endpoint {
    static let baseURL = "https://www.anapioficeandfire.com/api"
    
    enum Home: String {
        case house = "/houses"
        
        var absoluteURL: String {
            "\(Endpoint.baseURL)\(self.rawValue)"
        }
    }
}
