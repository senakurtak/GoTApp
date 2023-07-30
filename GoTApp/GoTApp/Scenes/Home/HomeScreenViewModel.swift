//
//  HomeScreenViewModel.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import Foundation

protocol HomeScreenViewModelProtocol {
    var houses: [HouseResponse] { get }
    var selectedHouse: HouseResponse? { get set }
    func fetchHouseList()
}

final class HomeScreenViewModel: ObservableObject, HomeScreenViewModelProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    @Published var houses: [HouseResponse] = []
    @Published var selectedHouse: HouseResponse? = nil
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchHouseList() {
        networkManager.fetchHouses { result in
            switch result {
            case .success(let houses):
                DispatchQueue.main.async {
                    self.houses = houses
//                    print(houses.first)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
