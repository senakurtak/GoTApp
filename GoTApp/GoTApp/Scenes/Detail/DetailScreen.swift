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
    var padding: CGFloat = 10
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Region")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: UIScreen.main.bounds.width - padding, height: 50, alignment: .leading)
                    Text("\(house.region)")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .frame(width: UIScreen.main.bounds.width - padding, height: 50, alignment: .leading)
                    
                    if house.coatOfArms != "" {
                        Text("Coat of Arms")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(width: UIScreen.main.bounds.width - padding, height: 50, alignment: .leading)
                        Text("\(house.coatOfArms)")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(width: UIScreen.main.bounds.width - padding, alignment: .leading)
                            .background(Color.red)
                    }
                    
                    Text("Overlord Info")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: UIScreen.main.bounds.width - padding, height: 50, alignment: .leading)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300)
                .background(Color.white)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("GoTWhite"), Color("GoTDarkGray")]), startPoint: .top, endPoint: .bottom))
            .onAppear {
                    viewModel.fetchOverlord()
                print(house.coatOfArms)
            }
        }
        .navigationTitle(house.name)
    }
}
