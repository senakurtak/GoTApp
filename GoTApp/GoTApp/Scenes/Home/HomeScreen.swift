//
//  HomeScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var viewModel = HomeScreenViewModel()
    
    var body: some View {
        NavigationView {
            
            List(viewModel.houses) { house in
                Button(action: {
                    viewModel.selectedHouse = house
                }) {
                    Text(house.name)
                }
            }
            .sheet(item: $viewModel.selectedHouse) { house in
                DetailScreen(house: house)
            }
            .navigationTitle("Houses")
            .listStyle(GroupedListStyle())
            Spacer()
            .onAppear{
                viewModel.fetchHouseList()
            }
        }
    }
}
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
