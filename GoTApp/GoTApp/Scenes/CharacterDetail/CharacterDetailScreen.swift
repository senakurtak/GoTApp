//
//  CharacterDetailScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 31.07.2023.
//

import SwiftUI

struct CharacterDetailScreen: View {
    
    let character: CharacterResponse
    
    var body: some View {
        Text(character.name)
    }
        
}
