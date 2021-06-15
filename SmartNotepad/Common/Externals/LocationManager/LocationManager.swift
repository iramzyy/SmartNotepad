//
//  LocationManager.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    static let shared = LocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func updateCurrentLocation(){
        self.locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }
    
    func getLocationAddress(_ location: CLLocation, _ handler: @escaping ((String?) -> Void)) {
        CLGeocoder().reverseGeocodeLocation(location) { placeMark,error in
            if error != nil {
                handler(nil)
                return
            }
            if let places = placeMark {
                if places.count > 0 {
                    guard let place = places.last else {return}
                    var addressString : String = ""
                    if place.subLocality != nil {
                        addressString = addressString + place.subLocality! + ", "
                    }
                    if place.thoroughfare != nil {
                        addressString = addressString + place.thoroughfare! + ", "
                    }
                    if place.locality != nil {
                        addressString = addressString + place.locality! + ", "
                    }
                    if place.country != nil {
                        addressString = addressString + place.country! + ", "
                    }
                    if place.postalCode != nil {
                        addressString = addressString + place.postalCode! + " "
                    }
                    handler(addressString)
                }
            }
        }
    }
    
    func getDistanceInMeters (currentLatitude: Double, currentLongitude: Double, locationLatitude: Double, locationLongitude: Double) -> Double{
        let currentLocation = CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        let location = CLLocation(latitude: locationLatitude, longitude: locationLongitude)
        
        return currentLocation.distance(from: location)
    }

    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            @unknown default:
                fatalError("Can not access location")
            }
        } else {
            hasPermission = false
        }
        return hasPermission
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        guard let location = locations.last else {
            return
        }
        currentLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError   error: Error) {
        print(error.localizedDescription)
    }
}
