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
    
    private let networkManager: NetworkManager<[HouseResponse]>

    @Published var houses: [HouseResponse] = []
    @Published var selectedHouse: HouseResponse? = nil
    
    init(networkManager: NetworkManager<[HouseResponse]> = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchHouseList() {
        networkManager.fetchData(from: Endpoint.Home.house.absoluteURL) { (result: Result<[HouseResponse], NetworkError>) in
            switch result {
            case .success(let houses):
                DispatchQueue.main.async {
                    self.houses = houses
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

