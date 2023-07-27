//
//  DetailScreenViewModel.swift
//  GoTApp
//
//  Created by Sena Kurtak on 27.07.2023.
//

import Foundation

protocol DetailScreenViewModelProtocol {
    var house: HouseResponse { get }
    func fetchHouse()
}

final class DetailScreenViewModel: ObservableObject, DetailScreenViewModelProtocol {
    
    var house: HouseResponse
    
    init(house: HouseResponse) {
        self.house = house
    }
    
    func fetchHouse() {
        
    }
}
