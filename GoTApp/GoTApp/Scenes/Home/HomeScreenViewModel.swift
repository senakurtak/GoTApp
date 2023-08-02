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
    func fetchAllHouses()
}

final class HomeScreenViewModel: ObservableObject, HomeScreenViewModelProtocol {
    
    private let networkManager: NetworkManager<[HouseResponse]>

    @Published var houses: [HouseResponse] = []
    @Published var selectedHouse: HouseResponse? = nil
    
    init(networkManager: NetworkManager<[HouseResponse]> = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchAllHouses() {
        fetchHouseList(page: 0)
    }
    
    private func fetchHouseList(page: Int) {
        
        let urlString = Endpoint.Home.house.absoluteURL + "?page=\(page)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        networkManager.fetchData(from: urlString) { (result: Result<[HouseResponse], NetworkError>) in
            switch result {
            case .success(let houses):
                DispatchQueue.main.async {
                    self.houses.append(contentsOf: houses)
                    if !houses.isEmpty {
                        self.fetchHouseList(page: page + 1)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
