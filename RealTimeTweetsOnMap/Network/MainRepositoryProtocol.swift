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
    
    var tweetCoordinatesPublisher: Published<[CLLocationCoordinate2D]>.Publisher { get }
    var lastCoordinatePublisher: Published<CLLocationCoordinate2D>.Publisher { get }
    
    func fecthTweets(_ withRule: String)
    
    func removeFirstCoordinate()
    
}
