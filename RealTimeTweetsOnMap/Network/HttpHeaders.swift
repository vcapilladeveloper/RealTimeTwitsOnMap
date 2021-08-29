//
//  HttpHeaders.swift
//  HttpHeaders
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation


public struct HttpHeaders {

    // MARK: - Properties
    public var headers = [HttpHeader]()
    
    // MARK: Custom
    init() { }
    
    /// Init with array
    /// - Parameter headers: HTTPHeader array
    public init(_ headers: [HttpHeader]) {
        self.init()

        self.headers = headers
        
    }
    
    /// Init with raw dictionary
    /// - Parameter dictionary: Dictionary
    public init(_ dictionary: [String: String]) {
        self.init()

        self.headers = dictionary.map({ HttpHeader(name: $0, value: $1) })
        
    }
    
    /// Add raw header by name/value
    /// - Parameters:
    ///   - name: Name
    ///   - value: Value
    public mutating func add(name: String, value: String) {
       
        headers.append(HttpHeader(name: name, value: value))
        
    }
    
    /// Add HTTPHeader
    /// - Parameter header: Header
    public mutating func add(_ header: HttpHeader) {
        
        headers.append(header)
        
    }
    
    /// Remove header by name
    /// - Parameter name: Header name
    public mutating func remove(name: String) {
        
        guard let index = headers.firstIndex(where: { $0.name == name }) else { return }
        headers.remove(at: index)
        
    }

    /// The dictionary representation of all headers.
    ///
    /// This representation does not preserve the current order of the instance.
    public var dictionary: [String: String] {
        
        let namesAndValues = headers.map { ($0.name, $0.value) }
        return Dictionary(namesAndValues, uniquingKeysWith: { _, last in last })
        
    }
    
}

extension HttpHeaders: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (String, String)...) {
        self.init()

        elements.forEach { add(name: $0.0, value: $0.1) }
        
    }
    
}

public struct HttpHeader: Hashable {
    
    // MARK: - Properties
    public let name: String
    public let value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
}

extension HttpHeader {
    
    public static func accept(_ value: String) -> HttpHeader {
        HttpHeader(name: "Accept", value: value)
    }
    
    public static func acceptCharset(_ value: String) -> HttpHeader {
        HttpHeader(name: "Accept-Charset", value: value)
    }
    
    public static func acceptLanguage(_ value: String) -> HttpHeader {
        HttpHeader(name: "Accept-Language", value: value)
    }
    
    public static func acceptEncoding(_ value: String) -> HttpHeader {
        HttpHeader(name: "Accept-Encoding", value: value)
    }
    
    public static func authorization(username: String, password: String) -> HttpHeader {
        let credential = Data("\(username):\(password)".utf8).base64EncodedString()
        return authorization("Basic \(credential)")
    }
    
    public static func authorization(bearerToken: String) -> HttpHeader {
        authorization("Bearer \(bearerToken)")
    }
    
    public static func authorization(_ value: String) -> HttpHeader {
        HttpHeader(name: "Authorization", value: value)
    }
    
    public static func contentDisposition(_ value: String) -> HttpHeader {
        HttpHeader(name: "Content-Disposition", value: value)
    }
    
    public static func contentType(_ value: String) -> HttpHeader {
        HttpHeader(name: "Content-Type", value: value)
    }
    
    public static func userAgent(_ value: String) -> HttpHeader {
        HttpHeader(name: "User-Agent", value: value)
    }
    
    public static func xAuthToken(_ value: String) -> HttpHeader {
        HttpHeader(name: "X-Auth-Token", value: value)
    }
}

extension HttpHeader {
    
    /// Default Accep-Encoding header
    public static let defaultAcceptEncoding: HttpHeader = {
        
        let encodings = ["br", "gzip", "deflate"]
        return .acceptEncoding(encodings.qualityEncoded())
        
    }()
    
    /// Default Accept-Language header
    public static let defaultAcceptLanguage: HttpHeader = {
        
        .acceptLanguage(Locale.preferredLanguages.prefix(6).qualityEncoded())
        
    }()
    
}

extension Collection where Element == String {
    
    /// Add quality to values
    func qualityEncoded() -> String {
        
        return enumerated().map { index, encoding in
            let quality = 1.0 - (Double(index) * 0.1)
            return "\(encoding);q=\(quality)"
        }.joined(separator: ", ")
        
    }
    
}
