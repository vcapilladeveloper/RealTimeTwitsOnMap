//
//  GeoModel.swift
//  RealTimeTwitsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation

struct GeoModel: Codable {
    let id, fullName, country: String
    let centroid: [Double]
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case country, centroid
    }
}
