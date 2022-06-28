//
//  PlacesService.swift
//  sunseeker
//
//  Created by gary.odonoghue  on 25/06/2022.
//

import Foundation
import GooglePlaces


class PlacesService {
    
    private var placesClient = GMSPlacesClient.shared()
    static let shared = PlacesService()
    
    func getPlaces(completion: @escaping(([Place]) -> Void)) {
        
        var places: [Place] = []
        let myGroup = DispatchGroup()
        
        myGroup.enter()
        
        getPlacesFromCurrentLocation { bars in
            for bar in bars {
                myGroup.enter()
                self.placesClient.lookUpPlaceID(bar.placeID!) { successResponse, error in
                    guard let response = successResponse else { return }
                    let place = Place(placeID: bar.placeID!, name: bar.name!, location: response.coordinate)
                    
                    places.append(place)
                    myGroup.leave()
                }
            }
            myGroup.leave()
        }
        
        myGroup.notify(queue: .main) {
            completion(places)
        }
    }
    
    func getPlacesFromCurrentLocation(completion: @escaping ([GMSPlace]) -> Void) {
        
        let placeFields: GMSPlaceField = [.name, .placeID, .types, .coordinate]
        
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { (placeLikelihoods, error) in
            guard let placesResponse = placeLikelihoods else {
                return
            }
            
            guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                return
            }
            
            completion(placesResponse.compactMap{ $0.place })
        }
    }
}

struct Place: Identifiable {
    let id = UUID()
    let placeID: String
    let name: String
    let location: CLLocationCoordinate2D
}
