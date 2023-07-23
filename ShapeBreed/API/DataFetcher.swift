//
//  DataFetcher.swift
//  ShapeBreed
//
//  Created by Jakub Patelski on 23/07/2023.
//

import Foundation

struct Breeds: Codable {
    let message: [String: [String]]
}

class BreedsData: ObservableObject {
    @Published var breedNames = [String]()
    
    init()  {
        guard let url = URL(string: "https://dog.ceo/api/breeds/list/all") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
                
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Breeds.self, from: data)                
                
                DispatchQueue.main.async {
                    self.breedNames = result.message.keys.sorted()
                }
                
                
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")

            }
            
        }.resume()
        
    }
    
}
