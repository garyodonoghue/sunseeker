//
//  PlacesViewModel.swift
//  sunseeker
//
//  Created by gary.odonoghue  on 28/06/2022.
//

import CoreLocation

class PlacesViewModel: NSObject, ObservableObject {
    
    @Published var places = [Place]()
    
    private let locationManager = CLLocationManager()
    let placesService = PlacesService.shared
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
}

extension PlacesViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            placesService.getPlaces { places in
                self.places = places
            }
        }
    }
}
