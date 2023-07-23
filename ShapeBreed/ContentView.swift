//
//  ContentView.swift
//  ShapeBreed
//
//  Created by Jakub Patelski on 23/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    @ObservedObject var breedsData = BreedsData()
    @ObservedObject  var imagesData = ImagesData()


    var body: some View {
        NavigationView {
            VStack {
                List(breedsData.breedNames, id: \.self) { breedName in
                    NavigationLink(destination: BreedImageView(breedName: breedName, imagesData: imagesData)) {
                        Text(breedName.capitalized)
                            .font(.system(size: 18, weight: .medium))

                    }
                }
                .navigationTitle("Dog Breeds")
                .toolbar{
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            Button("Favourites"){
                                showSheet.toggle()
                            }
                            .font(.system(size: 20))
                            
                        }
                }
                .sheet(isPresented: $showSheet) {
                    FavouritesView(imagesData: imagesData, breedsData: breedsData)

                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
