//
//  Bird.swift
//  BirdUp
//
//  Created by dmu mac 26 on 09/12/2024.
//

import Foundation
import FirebaseFirestore
import CoreLocation


struct Bird: Identifiable, Codable {
    
    @DocumentID var id: String?
    let species: Species
    let note: String
    let picture: Data?
    var date = Date()
    let location: GeoPoint
    
    struct Location: Codable {
        let latitude: String
        let longitude: String
        
        func toString() -> String {
            return "\(latitude), \(longitude)"
        }
    }
    
    enum Species: String, Codable, CaseIterable, Identifiable {
        case parrot = "Parrot"
        case sparrow = "Sparrow"
        case pigeon = "Pigeon"
        case eagle = "Eagle"
        case owl = "Owl"
        case penguin = "Penguin"
        case flamingo = "Flamingo"
        case hawk = "Hawk"
        case canary = "Canary"
        case other = "Other"
        
        var id: String { self.rawValue }
        
        init(from string: String) {
            self = Species(rawValue: string) ?? .other
        }
    }
}

struct TestBird {
    static var bird = Bird(species: .parrot, note: "This is a parrot", picture: nil, location: GeoPoint(latitude: 38.897957, longitude: -77.036560))
}
