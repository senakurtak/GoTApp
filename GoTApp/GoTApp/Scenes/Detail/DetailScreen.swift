//
//  DetailScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import SwiftUI

struct DetailScreen: View {
    
    let house: HouseResponse
    
    @State var viewModel: DetailScreenViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 812)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("GoTWhite"), Color("GoTDarkGray")]), startPoint: .top, endPoint: .bottom))
            .onAppear {
                viewModel.fetchOverlord()
            }
        }
        .navigationTitle(house.name)
    }
}
