//
//  BirdUpApp.swift
//  BirdUp
//
//  Created by dmu mac 26 on 09/12/2024.
//

import SwiftUI
import Firebase

@main
struct BirdUpApp: App {
    
    init() {
        FirebaseApp.configure()
        
    }
    var body: some Scene {
        WindowGroup {
            MainPageView()
        }
    }
}
