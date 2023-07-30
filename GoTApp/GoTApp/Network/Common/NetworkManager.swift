//
//  NetworkManager.swift
//  GoTApp
//
//  Created by Sena Kurtak on 26.07.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchHouses(completion: @escaping (Result<[HouseResponse], NetworkError>) -> Void)
    func fetchOverlord(url: String, completion: @escaping (Result<OverlordResponse, NetworkError>) -> Void)
    func fetchCharacter(url: String, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func fetchCharacter(url: String, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)

        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(.noInternet))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.httpError(.bitWidth)))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                switch response.statusCode {
                case 400:
                    completion(.failure(.bodyInGet))
                case 403:
                    completion(.failure(.accessForbidden))
                case 404:
                    completion(.failure(.invalidURL))
                case 500:
                    completion(.failure(.invalidResponse(data, response)))
                default:
                    completion(.failure(.unknown))
                }
                return
            }
            do {
                let houses = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(houses))
            } catch {
                completion(.failure(.httpError(.bitWidth)))
            }
        }
        task.resume()
    }
    
    
    func fetchHouses(completion: @escaping (Result<[HouseResponse], NetworkError>) -> Void) {
        
        guard let url = URL(string: Endpoint.Home.house.absoluteURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(.noInternet))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.httpError(.bitWidth)))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                switch response.statusCode {
                case 400:
                    completion(.failure(.bodyInGet))
                case 403:
                    completion(.failure(.accessForbidden))
                case 404:
                    completion(.failure(.invalidURL))
                case 500:
                    completion(.failure(.invalidResponse(data, response)))
                default:
                    completion(.failure(.unknown))
                }
                return
            }
            
            do {
                let houses = try JSONDecoder().decode([HouseResponse].self, from: data)
                completion(.success(houses))
            } catch {
                completion(.failure(.httpError(.bitWidth)))
            }
            
        }
        task.resume()
    }
    
    func fetchOverlord(url: String, completion: @escaping (Result<OverlordResponse, NetworkError>) -> Void) {
            guard let url = URL(string: url) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.get.rawValue
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data = data, error == nil else {
                    if let error = error {
                        completion(.failure(.noInternet))
                    }
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.httpError(.bitWidth)))
                    return
                }
                
                guard (200...299).contains(response.statusCode) else {
                    switch response.statusCode {
                    case 400:
                        completion(.failure(.bodyInGet))
                    case 403:
                        completion(.failure(.accessForbidden))
                    case 404:
                        completion(.failure(.invalidURL))
                    case 500:
                        completion(.failure(.invalidResponse(data, response)))
                    default:
                        completion(.failure(.unknown))
                    }
                    return
                }
                
                do {
                    let overlord = try JSONDecoder().decode(OverlordResponse.self, from: data)
                    completion(.success(overlord))
                } catch {
                    completion(.failure(.httpError(.bitWidth)))
                }
            }
            task.resume()
        }
    
}
