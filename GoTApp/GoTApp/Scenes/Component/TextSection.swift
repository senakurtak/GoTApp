//
//  TextSection.swift
//  GoTApp
//
//  Created by Sena Kurtak on 2.08.2023.
//

import SwiftUI

struct TextSection: View {
    
    // MARK: Properties
    let title: String
    let content: String
    var padding: CGFloat = 20

    // MARK: UI Elements
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .frame(width: UIScreen.main.bounds.width - padding, alignment: .bottomLeading)
            Text(content)
                .font(.system(size: 18, weight: .medium, design: .default))
                .frame(width: UIScreen.main.bounds.width - padding, alignment: .bottomLeading)
        }
    }
}

struct ImageTextSection: View {
    
    // MARK: Properties
    let image: String
    let content: String
    
    // MARK: UI Elements

    var body: some View {
        HStack{
            Image(systemName: image)
                .foregroundColor(.white)
                .imageScale(.large)
            Text(content)
                .foregroundColor(.white)
                .font(.body)
        }
    }
}
