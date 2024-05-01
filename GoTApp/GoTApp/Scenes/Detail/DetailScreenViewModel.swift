//
//  DetailScreenViewModel.swift
//  GoTApp
//
//  Created by Sena Kurtak on 27.07.2023.
//

import Foundation

protocol DetailScreenViewModelProtocol {
    var house: HouseResponse { get }
    func fetchOverlord() async
    func fetchCharacter() async
}

final class DetailScreenViewModel: ObservableObject, DetailScreenViewModelProtocol {
    
    private let networkManager: NetworkManager
    var house: HouseResponse

    @Published var overlord: OverlordResponse?
    @Published var characters: [CharacterResponse] = []

    init(house: HouseResponse, networkManager: NetworkManager = NetworkManager()) {
        self.house = house
        self.networkManager = networkManager
    }
    
    func fetchOverlord() async {
        do {
            let overlordResponse: OverlordResponse = try await networkManager.fetchData(from: house.overlord)
            DispatchQueue.main.async {
                self.overlord = overlordResponse
            }
            await fetchCharacter()
        } catch {
            print("Failed to fetch overlord: \(error)")
        }
    }
    
    func fetchCharacter() async {
        guard let overlord = overlord else { return }

        let swornMembersURLs = overlord.swornMembers
        if swornMembersURLs.isEmpty { return }

        for url in swornMembersURLs {
            await fetchCharacterInfo(from: url)
        }
    }

    private func fetchCharacterInfo(from url: String) async {
        do {
            let characterResponse: CharacterResponse = try await networkManager.fetchData(from: url)
            DispatchQueue.main.async {
                self.characters.append(characterResponse)
            }
        } catch {
            print("Failed to fetch character info: \(error)")
        }
    }
}
