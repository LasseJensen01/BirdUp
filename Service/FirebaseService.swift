//
//  FirebaseService.swift
//  BirdUp
//
//  Created by dmu mac 26 on 09/12/2024.
//
import Foundation
import FirebaseFirestore

struct FirebaseService {
    // Firebase Service clas
    //Setup of listener on Collection "Birds"
    private let dbCollection = Firestore.firestore().collection("Birds")
    private var listner: ListenerRegistration?
    mutating func setupListener(callback: @escaping ([Bird]) -> Void) {
        listner = dbCollection.addSnapshotListener(includeMetadataChanges: true) { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
            let birds = documents.compactMap{ queryBird -> Bird? in
                return try? queryBird.data(as: Bird.self)
            }
            callback(birds.sorted{ $0.date > $1.date })
            
        }
    }
    func addBird(bird: Bird){
        do {
            let _ = try dbCollection.addDocument(from: bird.self)
            print("Bird Added")
        }catch{
            print(error)
        }
    }
    func deleteBird(bird: Bird){
        guard let birdID = bird.id else { return }
        dbCollection.document(birdID).delete(){error in
            if let error{
                print("Error when deleting bird: \(error)")
            }
        }
    }
}
