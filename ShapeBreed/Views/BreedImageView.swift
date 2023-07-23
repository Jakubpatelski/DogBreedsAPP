//
//  BreedImageView.swift
//  ShapeBreed
//
//  Created by Jakub Patelski on 23/07/2023.
//

import SwiftUI

struct BreedImageView: View {
    let breedName: String
    @ObservedObject var imagesData: ImagesData
    
    var body: some View {
        List(imagesData.imageUrls, id: \.self) { imageUrl in
            VStack(alignment: .center, spacing: 15) {

                ImageView(imageUrl: imageUrl, breedName: breedName)
               
                    
                    
                    Button(action: {
                        if imagesData.favourites.contains(FavouriteImage(imageUrl: imageUrl, breedName: breedName)) {
                            imagesData.removeFromFavourites(breedName: breedName, imageUrl: imageUrl)
                        } else {
                            imagesData.addToFavourites(breedName: breedName, imageUrl: imageUrl)
                        }
                    }) {
                        Image(systemName: imagesData.favourites.contains(FavouriteImage(imageUrl: imageUrl, breedName: breedName)) ? "heart.fill" : "heart")
                            .font(.system(size: 25))
                            .foregroundColor(.red)
                    }
                
            }
            .padding()
        }
        .navigationTitle(breedName.capitalized)
        .onAppear {
            imagesData.fetchImages(breedName: breedName)
        }
    }
}

