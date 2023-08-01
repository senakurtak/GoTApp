//
//  SearchBar.swift
//  GoTApp
//
//  Created by Sena Kurtak on 1.08.2023.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String

    var body: some View {
        ZStack {
            TextField("Search", text: $searchText)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            Button(action: {
                searchText = ""
            }) {
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(8)
            }
        }
        .padding(.horizontal)
    }
}
