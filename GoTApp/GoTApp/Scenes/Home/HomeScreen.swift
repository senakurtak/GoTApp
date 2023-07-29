//
//  HomeScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var viewModel = HomeScreenViewModel()
    
    var columns: [GridItem] = [
        GridItem(.flexible(minimum: 100, maximum: 250), spacing: 0),
        GridItem(.flexible(minimum: 100, maximum: 250), spacing: 0),
    ]
    
    var cellWidth: CGFloat = 150
    var cellHeight: CGFloat = 100
    var padding: CGFloat = 10
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.houses) { house in
                        NavigationLink(destination: DetailScreen(house: house, viewModel: DetailScreenViewModel(house: house))) {
                            VStack(alignment: .leading) {
                                Text(house.name)
                                    .font(.headline)
                                    .foregroundColor(Color("GoTWhite"))
                            }
                            .padding(padding)
                            .frame(width: cellWidth, height: cellHeight)
                            .background(Color("GoTLightGray"))
                            .cornerRadius(8)
                        }
                        .padding(padding)
                    }
                }
                .padding(padding)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("GoTWhite"), Color("GoTDarkGray")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationTitle("List of Houses")
        }
        .onAppear {
            viewModel.fetchHouseList()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
