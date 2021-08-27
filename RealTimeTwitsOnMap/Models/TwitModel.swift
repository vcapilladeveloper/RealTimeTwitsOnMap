//
//  TwitModel.swift
//  RealTimeTwitsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation

struct TwitModel: Codable {
    let data: Twit
    
    
    struct Twit: Codable {
        let text, id: String
        let geo: Geo?
    }

    struct Geo: Codable {
        let placeId: String?
        
        enum CodingKeys: String, CodingKey {
            case placeId = "place_id"
        }
    }

}
