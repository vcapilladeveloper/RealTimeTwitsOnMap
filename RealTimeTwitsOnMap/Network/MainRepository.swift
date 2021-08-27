//
//  MainRepository.swift
//  RealTimeTwitsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation
import Combine
import CoreLocation.CLLocation

class MainRepository: NSObject, ObservableObject, URLSessionDataDelegate {
    
    @Published var twitCoordinates: [CLLocationCoordinate2D] = []
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        separateDataIntoLinesIfPlaceId(data).forEach { item in
            if let twit = decodeData(item) {
                if let geo = twit.data.geo {
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
    
    private func decodeData(_ item: String) -> TwitModel? {
        do {
            return try JSONDecoder().decode(TwitModel.self, from: item.data(using: .utf8) ?? Data())
        } catch {
            return nil
        }
    }
    
    private func getCoordinates(_ geo: TwitModel.Geo) {
        GeoEndpoint(geo.placeId ?? "").loadDataWithType().subscribe(Subscribers.Sink(receiveCompletion: { response in
//            print(response)
        }, receiveValue: { received in
            self.twitCoordinates.append(received.coordinates()) 
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
    
    func streamTwits() {
        StreamTwitsEndpoint().listenData(self as URLSessionDataDelegate)
    }
}
