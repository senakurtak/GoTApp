//
//  SideMenu.swift
//  GoTApp
//
//  Created by Sena Kurtak on 2.08.2023.
//

import SwiftUI

struct SideMenu: View {
    // MARK: Properties
    private let padding: CGFloat = 30
    private let horizontalPadding: CGFloat = 10
    
    // MARK: UI Elements

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.white)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.white)
                    .font(.body)
            }
            .padding(.top, padding)
            .padding(.leading, horizontalPadding)
            
            .foregroundColor(Color("GoTDarkGray"))
            
            NavigationLink(destination: FavoriteHousesScreen()) {
                ImageTextSection(image:"heart.circle.fill" , content: "Favorite Characters")
                    .padding(.top, padding)
                    .padding(.leading, horizontalPadding)
                    .foregroundColor(Color("GoTDarkGray"))
            }
            
            NavigationLink(destination: FavoriteHousesScreen()) {
                ImageTextSection(image:"house.circle.fill" , content: "Favorite Houses")
                    .padding(.top, padding)
                    .padding(.leading, horizontalPadding)
                
                    .foregroundColor(Color("GoTDarkGray"))
            }
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color("GoTDarkGray"))
                .edgesIgnoringSafeArea(.all)
        }
        .background(Color("GoTDarkGray"))
    }
}
