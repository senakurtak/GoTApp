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
    
    private let networkManager: NetworkManagerProtocol
    var house: HouseResponse
    @Published var characterNames: [String] = []
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
                    self.fetchCharacter()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCharacter() {
        guard let overlord = overlord else {
            print("Overlord is not available.")
            return
        }

        let swornMembersURLs = overlord.swornMembers
        
        if swornMembersURLs.isEmpty {
            print("No sworn members available.")
            return
        }

        for url in swornMembersURLs {
            fetchCharacterInfo(from: url)
        }
    }

    private func fetchCharacterInfo(from url: String) {
        networkManager.fetchCharacter(url: url) { result in
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    print("Character Name: \(character.name)")
                    let name = character.name
                    self.characterNames.append(name)
                }
            case .failure(let error):
                print("Failed to fetch character info: \(error)")
            }
        }
    }

}
