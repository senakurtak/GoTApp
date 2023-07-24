//
//  DetailScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import SwiftUI

struct DetailScreen: View {
    
    let house: HouseResponse
    
    var body: some View {
        VStack {
            Text(house.name)
                .font(.title)
                .foregroundColor(.red)
            Spacer()
        }.navigationBarTitle(Text(house.name), displayMode: .inline)
    }
}
