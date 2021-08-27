//
//  ConfigUtilsTest.swift
//  RealTimeTwitsOnMapTests
//
//  Created by Victor Capilla Developer on 27/8/21.
//


import XCTest
@testable import RealTimeTwitsOnMap

class ConfigUtilsTest: XCTestCase {

    func test_bundle_identifier_with_config_utils() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let value = ConfigUtils.getConfiguration(with: "CFBundleIdentifier")
        XCTAssertEqual(value, "com.vcapilladeveloper.RealTimeTwitsOnMap")
    }
    
    func test_empty_with_config_utils() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let value = ConfigUtils.getConfiguration(with: "")
        XCTAssertNil(value)
    }


}
