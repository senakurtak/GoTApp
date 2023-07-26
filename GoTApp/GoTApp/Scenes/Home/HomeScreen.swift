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
                NavigationLink(destination: DetailScreen(house: house)) {
                    Text(house.name)
                }
            }

            .listStyle(GroupedListStyle())
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
