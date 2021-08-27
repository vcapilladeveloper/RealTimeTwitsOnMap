import Foundation
import Combine

public typealias NetworkResult<T: Codable> = Result<T, Error>

open class NetworkManager {
    
    static var defaultSession: URLSession = .shared
    static var dataTask: URLSessionDataTask?
    
    public static func requestData<T, E: Endpoint>(_ endpoint: E, completion: @escaping (NetworkResult<T>) -> Void)  {
        guard let url = URL(string: endpoint.getStringURL()) else {
            fatalError("Could not create URL from the given URL components.")
        }
        dataTask?.cancel()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        if let params = endpoint.parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            } catch (let formatError) {
                completion(.failure(formatError))
            }
        }
        
        if let header = endpoint.headers {
            urlRequest.allHTTPHeaderFields = header.dictionary
        }
        
        dataTask = defaultSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let error = error  {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let parsedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(parsedData))
                } catch (let fError) {
                    print(fError)
                    completion(.failure(fError))
                }
            }
        })
        do {dataTask?.resume()}
    }

    public static func listenData<E: Endpoint>(_ endpoint: E, delegate: URLSessionDelegate)  {
        guard let url = URL(string: endpoint.getStringURL()) else {
            fatalError("Could not create URL from the given URL components.")
        }
        dataTask?.cancel()
        var urlRequest = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: .infinity)
       
        
        urlRequest.httpMethod = endpoint.method.rawValue
               
        if let header = endpoint.headers {
            urlRequest.allHTTPHeaderFields = header.dictionary
        }
        
        urlRequest.timeoutInterval = .infinity
        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: .main)
        
        let dataTask = session.dataTask(with: urlRequest)

        do {dataTask.resume()}
    }
    
    
    
    public static func request<T: Decodable, E: Endpoint>(_ endpoint: E, type: T.Type, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
        
        let request = NetworkManager.makeRequest(endpoint)
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: { (data, response) in
                
                if endpoint.showDebugInfo {
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("\nSTATUS CODE:\n\(httpResponse.statusCode)\n")
                    }
                    if let headers = request.allHTTPHeaderFields {
                        print("HEADERS:\n\(headers)\n")
                    }
                    if let method = request.httpMethod {
                        print("METHOD:\n\(method)\n")
                    }
                    if let url = response.url?.absoluteString {
                        print("URL:\n\(url)\n")
                    }
                    if let bodyData = request.httpBody, let body = String(data: bodyData, encoding: .utf8) {
                        print("BODY DATA:\n\(body)\n")
                    }
                    if let value = String(data: data, encoding: .utf8) {
                        print("RESPONSE DATA:\n\(value)\n")
                    }
                }
                
            })
            .map({ $0.data })
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    
    public static func request<E: Endpoint>(_ endpoint: E) -> AnyPublisher<HTTPURLResponse, URLSession.DataTaskPublisher.Failure> {
        
        let request = self.makeRequest(endpoint)
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: { (data, response) in
                
                if endpoint.showDebugInfo {
                    
                    if let method = request.httpMethod {
                        print("\nMETHOD:\n\(method)\n")
                    }
                    if let url = response.url?.absoluteString {
                        print("URL:\n\(url)\n")
                    }
                    if let bodyData = request.httpBody, let body = String(data: bodyData, encoding: .utf8) {
                        print("BODY DATA:\n\(body)\n")
                    }
                    if let value = String(data: data, encoding: .utf8) {
                        print("RESPONSE DATA:\n\(value)\n")
                    }
                    
                }
                
            })
            .compactMap { $0.response as? HTTPURLResponse }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
}

private extension NetworkManager {
    
    /// Create URLRequest from endpoint
    /// - Returns: URLRequest
    static func makeRequest<E: Endpoint>(_ endpoint: E) -> URLRequest {
        
        // URL
        guard let url = URL(string: endpoint.baseURLString + endpoint.path) else { fatalError("Endpoint URL is invalid") }
        var request = URLRequest(url: url)
        
        // Method
        request.httpMethod = endpoint.method.rawValue
        
        // Headers
        request.allHTTPHeaderFields = endpoint.headers?.dictionary
        
        // Parameters
        if let params = endpoint.paramEncoding {
            switch params {
            case .URLEncoding:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
                components?.queryItems = endpoint.parameters?.map({
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                })
                request.url = components?.url
                
            case .JSONEncoding:
                if let params = endpoint.parameters {
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
            case .noEncoding:
                request.httpBody = endpoint.body
                
            }
        }
        
        return request
        
    }
}
