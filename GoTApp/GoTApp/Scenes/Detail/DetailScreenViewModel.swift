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
    func fetchCharacter()
}

final class DetailScreenViewModel: ObservableObject, DetailScreenViewModelProtocol {
    
    private let networkManager: NetworkManager<OverlordResponse>
    var house: HouseResponse
    
    @Published var overlord: OverlordResponse?
    @Published var character: CharacterResponse?
    @Published var characters: [CharacterResponse] = []

    init(house: HouseResponse, networkManager: NetworkManager<OverlordResponse> = NetworkManager()) {
        self.house = house
        self.networkManager = networkManager
    }
    
    func fetchOverlord() {
        networkManager.fetchData(from: house.overlord) { (result: Result<OverlordResponse, NetworkError>)  in
            switch result {
            case .success(let overlord):
                DispatchQueue.main.async {
                    self.overlord = overlord
                    self.fetchCharacter()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCharacter() {
        guard let overlord = overlord else { return }

        let swornMembersURLs = overlord.swornMembers
        
        if swornMembersURLs.isEmpty { return }

        for url in swornMembersURLs {
            fetchCharacterInfo(from: url)
        }
    }

    private func fetchCharacterInfo(from url: String) {
        networkManager.fetchData(from: url) { (result: Result<CharacterResponse, NetworkError>) in
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    let name = character.name
                    self.characters.append(character)
                }
            case .failure(let error):
                print("Failed to fetch character info: \(error)")
            }
        }
    }

}
