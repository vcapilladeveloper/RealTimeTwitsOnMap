//
//  ConfigUtilsTest.swift
//  RealTimeTweetsOnMapTests
//
//  Created by Victor Capilla Developer on 27/8/21.
//


import XCTest
@testable import RealTimeTweetsOnMap

class ConfigUtilsTest: XCTestCase {

    func test_bundle_identifier_with_config_utils() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let value = ConfigUtils.getConfiguration(with: "CFBundleIdentifier")
        XCTAssertEqual(value, "com.vcapilladeveloper.RealTimeTweetsOnMap")
    }
    
    func test_empty_with_config_utils() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let value = ConfigUtils.getConfiguration(with: "")
        XCTAssertNil(value)
    }


}
