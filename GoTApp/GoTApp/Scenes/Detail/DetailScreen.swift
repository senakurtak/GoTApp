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
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                    }
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200, alignment: .center)
                            .background(Color("GoTDarkGray"))
                            .cornerRadius(10)
                    }
                }
            }
            .background(Color("GoTWhite"))
            .frame(width: 375, height: 812)
        }
        .navigationTitle(house.name)
        .background(Color("GoTDarkGray"))
    }
}
