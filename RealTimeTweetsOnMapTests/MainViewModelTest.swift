//
//  MainViewModelTest.swift
//  RealTimeTweetsOnMapTests
//
//  Created by Victor Capilla Developer on 28/8/21.
//

import XCTest
import CoreLocation.CLLocation
@testable import RealTimeTweetsOnMap

class MainViewModelTest: XCTestCase {

    var mockMainRepository = MainRepositoryMock()
    var sut: MainViewModel<MainRepositoryMock>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = MainViewModel(mockMainRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    
    func test_view_model_region_center() {
        XCTAssertEqual(sut.region.center.latitude, 1.0)
        XCTAssertEqual(sut.region.center.longitude, 2.0)
    }
    
    func test_view_model_annotations_to_show() {
        XCTAssertEqual(sut.annotationsToShow.count, 3)
    }
    
    func test_view_model_annotations_equal_repositoru_tweets() {
        XCTAssertEqual(sut.annotationsToShow.count, sut.repository.tweetCoordinates.count)
    }
    
}
