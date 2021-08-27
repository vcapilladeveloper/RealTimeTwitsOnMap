//
//  MainViewModel.swift
//  RealTimeTwitsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation
import MapKit
import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    @Published var annotationsToShow: [CLLocationCoordinate2D] = []
    @Published var keyWord = ""
    @Published var pinLifeCycle = 5
    @ObservedObject var repository = MainRepository()
    
    var lifeTimeOptions = [ 5, 10, 15 ]
    
    func processData() {
        annotationsToShow = repository.twitCoordinates
        if let lastItem = repository.twitCoordinates.last { region.center = lastItem }
    }
    
    func setRule() {
        RemoveRuleEndpoint().loadData().subscribe(Subscribers.Sink(receiveCompletion: { response in
            print("\(response)")
        }, receiveValue: { result in
            AddRuleEndpoint(self.keyWord).loadData().subscribe(Subscribers.Sink(receiveCompletion: { response in
                print(response)
            }, receiveValue: { result in
                
                self.repository.streamTwits()
                
            }
            ))
        }))
    }
}

