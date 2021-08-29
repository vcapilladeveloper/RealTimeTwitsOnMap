//
//  TweetModel.swift
//  RealTimeTweetsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation

struct TweetModel: Codable {
    let data: Tweet
    
    
    struct Tweet: Codable {
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
