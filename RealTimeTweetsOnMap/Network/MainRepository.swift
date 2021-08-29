//
//  MainRepository.swift
//  RealTimeTweetsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation
import Combine
import CoreLocation.CLLocation

class MainRepository: NSObject, MainRepositoryProtocol, ObservableObject, URLSessionDataDelegate {
    
    @Published var tweetCoordinates: [CLLocationCoordinate2D] = []
    @Published var lastCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
    
    
    func fecthTweets(_ withRule: String) {
        
        RemoveRuleEndpoint().loadData().subscribe(Subscribers.Sink(receiveCompletion: { response in
            print("\(response)")
        }, receiveValue: { result in
            AddRuleEndpoint(withRule).loadData().subscribe(Subscribers.Sink(receiveCompletion: { response in
                print(response)
            }, receiveValue: { result in
                self.streamTweets()
            }
            ))
        }))

    }
    
    func removeFirstCoordinate() {
        if tweetCoordinates.count > 0 {
            let _ = tweetCoordinates.removeFirst()
        }
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        separateDataIntoLinesIfPlaceId(data).forEach { item in
            if let tweet = decodeData(item) {
                if let geo = tweet.data.geo {
                    getCoordinates(geo)
                }
            }
        }
    }
    
    private func separateDataIntoLinesIfPlaceId(_ data: Data) -> [String] {
        let str = String(decoding: data, as: UTF8.self)
        let lines = str.components(separatedBy: "\n")
        return lines.filter{$0.contains("place_id")}
    }
    
    private func decodeData(_ item: String) -> TweetModel? {
        do {
            return try JSONDecoder().decode(TweetModel.self, from: item.data(using: .utf8) ?? Data())
        } catch {
            return nil
        }
    }
    
    private func getCoordinates(_ geo: TweetModel.Geo) {
        GeoEndpoint(geo.placeId ?? "").loadDataWithType().subscribe(Subscribers.Sink(receiveCompletion: { response in
//            print(response)
        }, receiveValue: { received in
            self.tweetCoordinates.append(received.coordinates())
            self.lastCoordinate = received.coordinates()
            
        }))
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard challenge.previousFailureCount == 0 else {
            challenge.sender?.cancel(challenge)
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let allowAllCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, allowAllCredential)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print(error)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("3. received data")
    }
    
    func streamTweets() {
        StreamTweetsEndpoint().listenData(self as URLSessionDataDelegate)
    }
}
