//
//  ImageDataFetcher.swift
//  ShapeBreed
//
//  Created by Jakub Patelski on 23/07/2023.
//

import Foundation

struct ImagesResposne: Codable {
    let message: [URL]
}

struct FavouriteImage: Hashable, Codable {
    let imageUrl: URL
    let breedName: String
}


class ImagesData: ObservableObject {
    @Published var imageUrls = [URL]()
    @Published var favourites = [FavouriteImage]()
    
    
    func fetchImages(breedName: String){
        guard let url = URL(string: "https://dog.ceo/api/breed/\(breedName)/images") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decode = JSONDecoder()
                let result = try decode.decode(ImagesResposne.self, from: data)
                
                DispatchQueue.main.async {
                    self.imageUrls = result.message
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                
            }
        }.resume()
        
    }
    
    func addToFavourites(breedName: String, imageUrl: URL) {
         let favourite = FavouriteImage(imageUrl: imageUrl, breedName: breedName)
         if !favourites.contains(favourite) {
             favourites.append(favourite)
         }
     }

     func removeFromFavourites(breedName: String, imageUrl: URL) {
         let favourite = FavouriteImage(imageUrl: imageUrl, breedName: breedName)
         if let index = favourites.firstIndex(of: favourite) {
             favourites.remove(at: index)
         }
     }

    
}
