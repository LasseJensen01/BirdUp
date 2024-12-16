//
//  LocationManager.swift
//  BirdUp
//
//  Created by dmu mac 26 on 10/12/2024.
//

import CoreLocation
@Observable
@MainActor
class LocationManager: NSObject, @preconcurrency CLLocationManagerDelegate {
    private let manager: CLLocationManager
    var lastLocation: CLLocation?
    
    override init(){
        self.manager = CLLocationManager()
        super.init()
        
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.manager.requestWhenInUseAuthorization()
        self.manager.delegate = self
    }
    
    func fetchCurrentLocation(){
        print("Fetching location...")
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                self.lastLocation = location
                print("Location fetched: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to fetch location: \(error.localizedDescription)")
        }
}
