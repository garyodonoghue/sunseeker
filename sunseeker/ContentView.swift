//
//  ContentView.swift
//  sunseeker
//
//  Created by gary.odonoghue  on 25/06/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {

    @ObservedObject private var viewModel = PlacesViewModel()
    @State private var amsterdamRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.370231, longitude: 4.871465), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    
    var body: some View {
        
        Map(coordinateRegion: $amsterdamRegion, annotationItems: viewModel.places) { place in
            MapAnnotation(coordinate: place.location) { 
                    Circle()
                        .stroke(.red, lineWidth: 3)
                        .frame(width: 4, height: 4)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
