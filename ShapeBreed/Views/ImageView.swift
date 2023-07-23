//
//  ImageView.swift
//  ShapeBreed
//
//  Created by Jakub Patelski on 23/07/2023.
//

import SwiftUI

struct ImageView: View {
    var imageUrl: URL
    var breedName: String

    var body: some View {
        
        AsyncImage(url: imageUrl) { image in
            image
                .resizable()
                .frame(height: 250)
                .cornerRadius(10)
        } placeholder: {
            ProgressView()
                .scaleEffect(5)
                .tint(.blue)
        }
        
        Text(breedName.capitalized)
            .foregroundColor(.blue)
       
    }
}


