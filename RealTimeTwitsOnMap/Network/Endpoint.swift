//
//  File.swift
//  File
//
//  Created by Victor Capilla Developer on 4/8/21.
//

import Foundation
import Combine

public protocol Endpoint {
    associatedtype  T
    
    var baseURLString: String { get }
    
    var path: String { get }
    
    var method: HttpMethod { get }
    
    var headers: HttpHeaders? { get }
    
    var parameters: [String: Any]? { get }
    
    var body: Data? { get }
    
    var paramEncoding: ParameterEncoding? { get }
    
    var showDebugInfo: Bool { get }
    
}

public extension Endpoint {
    
    func getStringURL() -> String {
        baseURLString + path
    }
    
    func loadData(_ completion: @escaping (NetworkResult<T>) -> Void) where T: Codable {
        NetworkManager.requestData(self, completion: completion)
    }
    
    func listenData(_ delegate: URLSessionDelegate) {
        NetworkManager.listenData(self, delegate: delegate)
    }
    
    func loadDataWithType() -> AnyPublisher<T, Error> where T: Codable {
        NetworkManager.request(self, type: T.self)
    }
    
    
    func loadData() -> AnyPublisher<HTTPURLResponse, URLSession.DataTaskPublisher.Failure> {
        NetworkManager.request(self)
    }
    
}


/// Supported HTTP methods
public enum HttpMethod: String {
    
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
    
}

/// Supported parameter encoding methods
public enum ParameterEncoding {
    
    case URLEncoding
    case JSONEncoding
    case noEncoding
    
}

