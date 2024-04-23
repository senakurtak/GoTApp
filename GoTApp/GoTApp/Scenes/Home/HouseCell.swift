//
//  HouseCell.swift
//  GoTApp
//
//  Created by Sena Kurtak on 23.04.2024.
//

import Foundation
import SwiftUI

struct HouseCell: View {
    var house: HouseResponse
    var cellWidth: CGFloat
    var cellHeight: CGFloat
    var padding: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text(house.name)
                .font(.headline)
                .foregroundColor(Color("GoTWhite"))
                .padding(padding)
                .frame(width: cellWidth, height: cellHeight)
                .background(Color("GoTDarkGray"))
                .cornerRadius(8)
        }
        .padding(padding)
    }
}
