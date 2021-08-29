//
//  MainRepositoryProtocol.swift
//  RealTimeTweetsOnMap
//
//  Created by Victor Capilla Developer on 28/8/21.
//

import Foundation
import CoreLocation.CLLocation
import Combine

protocol MainRepositoryProtocol where Self: ObservableObject {
    
    var tweetCoordinates: [CLLocationCoordinate2D] { get set }
    var lastCoordinate: CLLocationCoordinate2D { get set }
    
    func fecthTweets(_ withRule: String)
    
    func removeFirstCoordinate()
    
}
