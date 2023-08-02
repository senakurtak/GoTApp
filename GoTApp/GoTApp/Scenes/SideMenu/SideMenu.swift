//
//  SideMenu.swift
//  GoTApp
//
//  Created by Sena Kurtak on 2.08.2023.
//

import SwiftUI

struct SideMenu: View {
    
    private let padding: CGFloat = 30
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.white)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.top, padding)
            .padding(.leading, padding)
            
            .foregroundColor(Color("GoTDarkGray"))

            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.white)
                    .imageScale(.large)
                Text("Messages")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.top, padding)
            .padding(.leading, padding)

            .foregroundColor(Color("GoTDarkGray"))

            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.white)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            .padding(.top, padding)
            .padding(.leading, padding)

            .foregroundColor(Color("GoTDarkGray"))

            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color("GoTDarkGray"))
                .edgesIgnoringSafeArea(.all)
        }
        .background(Color("GoTDarkGray"))
    }
}
