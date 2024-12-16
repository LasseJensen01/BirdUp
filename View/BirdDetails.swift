//
//  BirdDetails.swift
//  BirdUp
//
//  Created by dmu mac 26 on 10/12/2024.
//

import SwiftUI
import MapKit

struct BirdDetails: View {
    let bird: Bird
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        ZStack{
            VStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(uiImage: bird.picture != nil ?
                              UIImage(data: bird.picture!)! :
                                UIImage(systemName: "bird")!)
                            .resizable()
                            .frame(width: 110, height: 110)
                            .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
                            .shadow(color: .gray, radius: 4)
                        Text(bird.species.rawValue)
                            .font(.title)
                            .padding()
                    }
                    
                    Map(position: $cameraPosition){
                        Marker("\(bird.species.rawValue)", coordinate:
                                CLLocationCoordinate2D(latitude:
                                                        Double(bird.location.latitude), longitude:
                                                        Double(bird.location.longitude)))
                    }.onAppear{
                        focusCameraOnBird()
                    }
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(color: .gray, radius: 5)
                    
                    
                }
                VStack(alignment: .center){
                    Text("Bird added: \(bird.date.formattedDescription)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding()
                    Divider()
                    Text(bird.note)
                        .padding()
                    Spacer()
                }
            }
        }
    }
    func focusCameraOnBird(){
        let latitude = bird.location.latitude
        let longitude = bird.location.longitude
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //Set Camera position on the bird
        cameraPosition = .camera(
                MapCamera(centerCoordinate: coordinate, distance: 500, pitch: 45)
            )
        
    }
}

#Preview {
    BirdDetails(bird: TestBird.bird)
}
