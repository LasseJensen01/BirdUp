//
//  BirdController.swift
//  BirdUp
//
//  Created by dmu mac 26 on 09/12/2024.
//

import Foundation
import SwiftUI

@Observable
class BirdController {
    var birds = [Bird]()
    
    @ObservationIgnored
    private var fireBaseService = FirebaseService()
    
    init() {
        fireBaseService.setupListener {fetchedBirds in
            self.birds = fetchedBirds
        }
    }
    
    func AddBird(bird: Bird){
        fireBaseService.addBird(bird: bird)
    }
    func DeleteBird(bird: Bird){
        fireBaseService.deleteBird(bird: bird)
    }
    
    
}


