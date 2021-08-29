//
//  AddRuleEndpoint.swift
//  RealTimeTweetsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation

let defaultTag = "SINGLE_TAG"

struct AddRuleEndpoint: Endpoint {
        
    typealias T = Void
    
    var baseURLString: String
    var path: String
    var method: HttpMethod
    var headers: HttpHeaders?
    var parameters: [String : Any]?
    var body: Data?
    var paramEncoding: ParameterEncoding?
    var showDebugInfo: Bool
    
    init(baseURLString: String, path: String, method: HttpMethod, headers: HttpHeaders? = nil, parameters: [String : Any]? = nil, body: Data? = nil, paramEncoding: ParameterEncoding? = nil, showDebugInfo: Bool) {
        self.baseURLString = baseURLString
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.body = body
        self.paramEncoding = paramEncoding
        self.showDebugInfo = showDebugInfo
    }
    
    init(_ rule: String) {
        self.init(baseURLString: ConfigUtils.getConfiguration(with: "BASE_URL") ?? "", path: "/2/tweets/search/stream/rules", method: .post, parameters: AddRuleEndpoint.addValue(rule), paramEncoding: .JSONEncoding, showDebugInfo: true)
        if let bearer = ConfigUtils.getConfiguration(with: "TWITTER_BEARER") {
            if headers != nil {
                self.headers?.add(name: "Authorization", value: "Bearer \(bearer)")
            } else {
                headers = HttpHeaders([HttpHeader(name: "Authorization", value: "Bearer \(bearer)")])
            }
        }
        
    }
    
    private static func addValue(_ value: String) -> [String: Any] {
        ["add": [["value": value, "tag": defaultTag]]] as [String: Any]
    }
    
}
