//
//  ContentView.swift
//  BirdUp
//
//  Created by dmu mac 26 on 09/12/2024.
//

import SwiftUI



struct ContentView: View {
    @Environment(BirdController.self) private var birdController
    @State private var showAddBird = false
    @State private var searchTxt = ""
    
    var filteredBirds: [Bird] {
        if (searchTxt.isEmpty){
            return birdController.birds
        } else {
            return birdController.birds.filter {bird in
                bird.species.rawValue.lowercased().contains(searchTxt.lowercased())
            }
        }
    }

    var body: some View {
        NavigationStack{
            ZStack{
                List{
                    ForEach(filteredBirds){bird in
                        NavigationLink{
                            BirdDetails(bird: bird)
                        } label: {
                            BirdRow(bird: bird)
                        }
                    }.onDelete{index in
                        let bird = birdController.birds[index.first!]
                        birdController.DeleteBird(bird: bird)
                        
                    }
                    
                }.searchable(text: $searchTxt, prompt: "Search by species")
                    .navigationTitle("Bird Sightings")
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: addBird){
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }.padding()
                }
            }
        }.sheet(isPresented: $showAddBird){
            AddBirdView().environment(LocationManager())
        }
    }
    private func addBird(){
        showAddBird = true
    }
}

#Preview {
    ContentView().environment(BirdController())
}
