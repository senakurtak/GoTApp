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
    private var requestOverlord: URLSessionTask?
    private var requestCharacter: URLSessionTask?

    @Published var overlord: OverlordResponse?
    @Published var characters: [CharacterResponse] = []

    init(house: HouseResponse, networkManager: NetworkManager<OverlordResponse> = NetworkManager()) {
        self.house = house
        self.networkManager = networkManager
    }
    
    func fetchOverlord() {
        requestOverlord?.cancel()
        requestOverlord = networkManager.fetchData(from: house.overlord) { [weak self] (result: Result<OverlordResponse, NetworkError>)  in
            switch result {
            case .success(let overlord):
                DispatchQueue.main.async {
                    self?.overlord = overlord
                    self?.fetchCharacter()
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
        requestCharacter?.cancel()
        requestCharacter = networkManager.fetchData(from: url) { [weak self] (result: Result<CharacterResponse, NetworkError>) in
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    self?.characters.append(character)
                }
            case .failure(let error):
                print("Failed to fetch character info: \(error)")
            }
        }
    }
    deinit {
        requestOverlord?.cancel()
        requestCharacter?.cancel()
    }
}
