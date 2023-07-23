//
//  FavouritesView.swift
//  ShapeBreed
//
//  Created by Jakub Patelski on 23/07/2023.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var imagesData: ImagesData
    @ObservedObject var breedsData: BreedsData
    
    @State private var selectedBreed: String = "All Breeds"
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Select Breed")) {
                        Picker("Select Breed", selection: $selectedBreed) {
                            Text("All Breeds").tag("All Breeds")
                            ForEach(breedsData.breedNames, id: \.self) { breedName in
                                Text(breedName.capitalized).tag(breedName)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.horizontal, 20)
                    }
                    
                    Section(header: Text("Favorite Images")) {
                        ForEach(imagesData.favourites, id: \.self) { favoriteImage in
                            if selectedBreed == "All Breeds" || favoriteImage.breedName == selectedBreed {
                                
                                ImageView(imageUrl: favoriteImage.imageUrl, breedName: favoriteImage.breedName.capitalized)
                                    .padding()

                            }
                        }
                    }
                }
            }
        }
    }
}
