//
//  MainViewModel.swift
//  RealTimeTwitsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation
import MapKit

class MainViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    @Published var annotationsToShow: [CLLocationCoordinate2D] = []
    @Published var keyWord = ""
    @Published var pinLifeCycle = 5
    @Published var annotations = [CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
        CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508),
        CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5),
        CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667)
    ]
    
    var lifeTimeOptions = [ 5, 10, 15 ]
    
    func processData() {
        if annotations.count > 0 {
            let annotation = annotations.removeFirst()
            region.center = annotation
            annotationsToShow.append(annotation)
        } else if annotationsToShow.count > 0 {
            annotationsToShow.removeFirst()
        }
    }
    
    func setRule() {
        
    }
    
}

