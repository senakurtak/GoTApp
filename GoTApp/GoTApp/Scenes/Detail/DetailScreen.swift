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
                    VStack {
                        Rectangle()
                            .foregroundColor(.red)
                            .frame(width: UIScreen.main.bounds.width, height: 400, alignment: .top)
                        VStack {
                            Text("Coat of Arms")
                                .padding(.top, 100)
                                .font(.title)
                                .multilineTextAlignment(.leading)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 100)
                            Text(house.coatOfArms)
                                .multilineTextAlignment(.leading)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 100)
                        }
                        
                        VStack {
                            Text("Region of House")
                                .padding(.top, 20)
                                .font(.title)
                                .multilineTextAlignment(.leading)
                                .frame(width: UIScreen.main.bounds.width - 40,height: 100)
                            
                            Text(house.region)
                                .padding(.top, 20)
                                .multilineTextAlignment(.leading)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 100)
                        }
                        VStack {
                            Text("Over Lords")
                                .padding(.top, 20)
                                .font(.title)
                                .multilineTextAlignment(.leading)
                                .frame(width: UIScreen.main.bounds.width - 40,height: 100)
                            
                            Text(house.region)
                                .padding(.top, 20)
                                .multilineTextAlignment(.leading)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 100)
                        }

                    }
                    ZStack {
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
