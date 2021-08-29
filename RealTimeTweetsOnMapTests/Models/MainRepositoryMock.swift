//
//  MainRepositoryMock.swift
//  RealTimeTweetsOnMapTests
//
//  Created by Victor Capilla Developer on 28/8/21.
//

import Foundation
import CoreLocation.CLLocation
@testable import RealTimeTweetsOnMap

class MainRepositoryMock: NSObject, MainRepositoryProtocol, ObservableObject {
    
    @Published var tweetCoordinates: [CLLocationCoordinate2D] =  [CLLocationCoordinate2D(latitude: 30.0, longitude: 40.0), CLLocationCoordinate2D(latitude: 50.0, longitude: 60.0), CLLocationCoordinate2D(latitude: 70.0, longitude: 80.0)]
    
    @Published var lastCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 1.0, longitude: 2.0)
    
    func fecthTweets(_ withRule: String) {
        
    }
    
    func removeFirstCoordinate() {
        if tweetCoordinates.count > 0 {
            let _ = tweetCoordinates.removeFirst()
            print(tweetCoordinates)
        }
    }
    
    func addElementToCoordinates() {
        tweetCoordinates.append(CLLocationCoordinate2D(latitude: 10.0, longitude: 20.0))
    }
    
}
