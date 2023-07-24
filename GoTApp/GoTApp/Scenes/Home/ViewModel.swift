//
//  ViewModel.swift
//  GoTApp
//
//  Created by Sena Kurtak on 25.07.2023.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var houses: [HouseResponse] = []
    
    @Published var selectedHouse: HouseResponse? = nil

    func fetchHouseList() {
        guard let url = URL(string: "https://www.anapioficeandfire.com/api/houses") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            // Convert to JSON
            do{
                let houses = try JSONDecoder().decode([HouseResponse].self, from: data)
                DispatchQueue.main.async {
                    self?.houses = houses
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func fetchHouse(url: String){
        guard let url = URL(string: url) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            // Convert to JSON
            do{
                let houses = try JSONDecoder().decode([HouseResponse].self, from: data)
                DispatchQueue.main.async {
                    self?.houses = houses
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
