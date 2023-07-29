//
//  DetailScreenViewModel.swift
//  GoTApp
//
//  Created by Sena Kurtak on 27.07.2023.
//

import Foundation

protocol DetailScreenViewModelProtocol {
    var house: HouseResponse { get }
    func fetchOverlord()
}

final class DetailScreenViewModel: ObservableObject, DetailScreenViewModelProtocol {

    private let networkManager: NetworkManagerProtocol
    var house: HouseResponse

    @Published var overlord: OverlordResponse?

    init(house: HouseResponse, networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.house = house
        self.networkManager = networkManager
    }

    func fetchOverlord() {
        networkManager.fetchOverlord(url: house.overlord) { result in
            switch result {
            case .success(let overlord):
                DispatchQueue.main.async {
                    self.overlord = overlord
                    print(overlord)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
