//
//  BirdRow.swift
//  BirdUp
//
//  Created by dmu mac 26 on 10/12/2024.
//

import SwiftUI


struct BirdRow: View {
    
    let bird: Bird
    var body: some View {
        HStack(spacing: 24.0){
            // Checks if the bird has an image, if yes load into an uiImage and display else load default bird
            Image(uiImage: bird.picture != nil ?
                  UIImage(data: bird.picture!)! :
                    UIImage(systemName: "bird")!)
                .resizable()
                .frame(width: 110, height: 110)
                .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
                .shadow(color: .gray, radius: 4)
            VStack(alignment: .leading, spacing: 4){
                HStack{
                    Text(bird.species.rawValue) // Species
                        .font(.headline)
                    Spacer()
                }
                Text(bird.date.formattedDescription)
                    .font(.subheadline) // Change to show Date
                Text("\(bird.location.latitude), \(bird.location.longitude)") // Coordinates
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
            }
        }
    }
}

#Preview {
    BirdRow(bird: TestBird.bird)
}
