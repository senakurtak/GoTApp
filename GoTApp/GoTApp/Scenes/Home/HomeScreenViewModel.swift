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
    func fetchAllHouses() async
}

final class HomeScreenViewModel: ObservableObject, HomeScreenViewModelProtocol {
    
    private var networkManager: NetworkManagerProtocol
    
    @Published var houses: [HouseResponse] = []
    @Published var selectedHouse: HouseResponse? = nil
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchAllHouses() async {
        var page = 0
        repeat {
            do {
                let fetchedHouses = try await fetchHouseList(page: page)
                DispatchQueue.main.async {
                    self.houses.append(contentsOf: fetchedHouses)
                }
                page += 1
            } catch {
                print("Failed to fetch houses: \(error)")
                return
            }
        } while true
    }
    
    private func fetchHouseList(page: Int) async throws -> [HouseResponse] {
        let urlString = Endpoint.Home.house.absoluteURL + "?page=\(page)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            throw NetworkError.invalidURL
        }
        return try await networkManager.fetchData(from: "\(url)")
    }
}
