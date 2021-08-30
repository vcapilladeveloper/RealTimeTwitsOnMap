//
//  MainViewModel.swift
//  RealTimeTweetsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation
import MapKit.MKGeometry
import Combine
import SwiftUI

class MainViewModel<Repository: MainRepositoryProtocol>: ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    @Published var annotationsToShow: [CLLocationCoordinate2D] = []
    @Published var keyWord = ""
    @Published var pinLifeCycle = 5
    var repository: Repository
    
    private var cancellable: Set<AnyCancellable> = []
    
    var timer: Timer?
    var lifeTimeOptions = [ 5, 10, 15 ]
    
    init(_ repository: Repository) {
        self.repository = repository
        repository.lastCoordinatePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] lastCoordinate in
                self?.region.center = lastCoordinate
            }.store(in: &cancellable)
        repository.tweetCoordinatesPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] coordinates in
                self?.annotationsToShow = coordinates
            }.store(in: &cancellable)
        
    }
    
    func startCountdownToRemovePin() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(pinLifeCycle), repeats: true) { [weak self] _ in
            self?.removeFirstItemForPinLife()
        }
    }
    
    func removeFirstItemForPinLife() {
        repository.removeFirstCoordinate()
    }
    
    func makeRequest() {
        startCountdownToRemovePin()
        repository.fecthTweets(keyWord)
    }
}

