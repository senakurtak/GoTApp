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
        NavigationView {
            ZStack {
                VStack {
                    Spacer(minLength: 50)
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                        Text(house.coatOfArms)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .frame(width: UIScreen.main.bounds.width - 40)
                    }
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200, alignment: .center)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color("GoTWhite"), Color("GoTDarkGray")]), startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(10)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 812)
        }
        .navigationTitle(house.name)
    }
}
