//
//  ExamplePatchEndpoint.swift
//  ExamplePatchEndpoint
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation
@testable import RealTimeTweetsOnMap

struct ExamplePatchEndpoint: Endpoint {
    
    typealias T = ExampleModel
    
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
    
    
}
