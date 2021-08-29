//
//  GeoModel.swift
//  RealTimeTweetsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation
import CoreLocation.CLLocation

struct GeoModel: Codable {
    let id, fullName, country: String
    let centroid: [Double]
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case country, centroid
    }
    
    func coordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.centroid.last ?? 0.0, longitude: self.centroid.first ?? 0.0)
    }
}
