//
//  NetworkManager.swift
//  GoTApp
//
//  Created by Sena Kurtak on 26.07.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchHouses(completion: @escaping (Result<[HouseResponse], Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func fetchHouses(completion: @escaping (Result<[HouseResponse], Error>) -> Void) {
        guard let url = URL(string: "https://www.anapioficeandfire.com/api/houses") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let houses = try JSONDecoder().decode([HouseResponse].self, from: data)
                completion(.success(houses))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
