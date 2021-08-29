//
//  ConfigUtils.swift
//  RealTimeTweetsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation


final class ConfigUtils {
    static func getConfiguration(with key: String) -> String? {
        if let value = Bundle.main.infoDictionary?[key] as? String {
            return value
        } else {
            return nil
        }
    }
}
