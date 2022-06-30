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
    
    @State private var selectedItem: Place?
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $amsterdamRegion, annotationItems: viewModel.places) { place in
                MapAnnotation(coordinate: place.location) {
                    Circle()
                        .stroke(.red, lineWidth: 3)
                        .frame(width: 4, height: 4)
                        .onTapGesture {
                            print("tapped \(place.name)")
                            selectedItem = place
                        }
                }
            }
            
            VStack {
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom, spacing: 20) {
                        ForEach(viewModel.places) { place in
                            
                            VStack {
                                Text(place.name)
                                    .foregroundColor(.gray)
                                    .font(.title3)
                                    .padding(.top, 20)
                                
                                Text(place.address)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                    .padding(.top, 20)
                                
                                Spacer()
                            }
                        }
                        .frame(width: 200, height: 200)
                        .background(.white)
                    }
                }
                .opacity(selectedItem == nil ? 0 : 1)
                .frame(height: 200)
            }
            .padding(.bottom, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

