//
//  HomeScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import SwiftUI

struct HomeScreen: View {
    
    // MARK: Properties
    @ObservedObject var viewModel = HomeScreenViewModel()
    @State var showMenu: Bool = false
    var columns: [GridItem] = [
        GridItem(.flexible(minimum: 100, maximum: 250), spacing: 0),
        GridItem(.flexible(minimum: 100, maximum: 250), spacing: 0),
    ]

    var cellWidth: CGFloat = 150
    var cellHeight: CGFloat = 100
    var padding: CGFloat = 10

    @State private var searchText = ""

    // MARK: Sorting Houses with or without Search Bar
    var filteredHouses: [HouseResponse] {
        if searchText.isEmpty {
            return viewModel.houses
        } else {
            return viewModel.houses.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // MARK: UI Elements
    var body: some View {
        NavigationView {

            GeometryReader { geometry in
                ZStack(alignment: .leading) {

                    VStack {
                        SearchBar(searchText: $searchText)
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 0) {
                                ForEach(filteredHouses) { house in
                                        VStack(alignment: .leading) {
                                            NavigationLink(destination: DetailScreen(house: house, viewModel: DetailScreenViewModel(house: house))) {
                                            Text(house.name)
                                                .font(.headline)
                                                .foregroundColor(Color("GoTWhite"))
                                        }
                                        .padding(padding)
                                        .frame(width: cellWidth, height: cellHeight)
                                        .background(Color("GoTDarkGray"))
                                        .cornerRadius(8)
                                    }
                                    .padding(padding)
                                }
                            }
                            .padding(padding)
                        }
                    }
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("GoTWhite"), Color("GoTDarkGray")]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                    )
                    .navigationTitle("List of Houses")

                    if self.showMenu {
                        SideMenu()
                            .frame(width: geometry.size.width / 2, height: geometry.size.height)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(DragGesture()
                            .onEnded {
                                if $0.translation.width < -100 {
                                    withAnimation {
                                        self.showMenu = false
                                    }
                                }
                            })
            }
            
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(Color("GoTDarkGray"))
                }
            ))
        }
        .onAppear {
            viewModel.fetchAllHouses()
        }
    }
}
