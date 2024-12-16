//
//  AddBirdView.swift
//  BirdUp
//
//  Created by dmu mac 26 on 10/12/2024.
//

import SwiftUI
import CoreLocation
import PhotosUI
import Foundation
import Firebase

struct AddBirdView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(LocationManager.self) private var locationManager
    @Environment(BirdController.self) private var birdController
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var selectedSpecies: Bird.Species = .other
    @State private var note: String = ""
    
    // Showcases current picture for the bird
    var birdImage: Image {
        guard let data = selectedImageData,
              let image = UIImage(data:data) else {
            return Image(systemName: "bird")
        }
        return Image(uiImage: image)
    }
    
    var body: some View{
        NavigationStack{
            Form{
                HStack(alignment: .center){
                    Text("Create Bird Sighting")
                        .font(.title)
                        .bold()
                    .padding()                }
                
                VStack{
                    Picker("Select Species", selection: $selectedSpecies){
                        ForEach(Bird.Species.allCases){species in
                            Text(species.rawValue).tag(species)
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5)))
                VStack{
                    TextEditor(text: $note)
                        .frame(height: 100)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5))
                        )
                }
                HStack {
                    birdImage
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    PhotosPicker(
                        selection: $selectedPhoto,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Label("Select Photo", systemImage: "photo")
                        }
                    
                }
                .onChange(of: selectedPhoto) {oldValue, newValue in
                    Task{
                        if let data = try? await newValue?.loadTransferable(type: Data.self){
                            selectedImageData = data
                        }
                    }
                }
                .padding()
                Button(action: {
                    addBirdAction()
                    dismiss()
                }){
                    Text("Add Sighting")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding(.top)
            }
        }.onAppear{
            locationManager.fetchCurrentLocation()
            print("Appeared")
        }
    }
    
    func addBirdAction(){
        // Convert Image into string, if none picked set as ""
        let imageData = selectedImageData ?? nil
        let latitude = locationManager.lastLocation!.coordinate.latitude
        let longitude = locationManager.lastLocation!.coordinate.longitude
        let newBird = Bird(species: selectedSpecies, note: note, picture: imageData,date: Date(), location: GeoPoint(latitude: latitude, longitude: longitude))
        birdController.AddBird(bird: newBird)
    }
}



#Preview {
    AddBirdView().environment(LocationManager()).environment(BirdController())
}
