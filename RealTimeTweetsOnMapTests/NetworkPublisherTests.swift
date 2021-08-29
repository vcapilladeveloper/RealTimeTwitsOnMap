//
// NetworkPublisherTests.swift
// NetworkPublisherTests
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import XCTest
import Combine
@testable import RealTimeTweetsOnMap

final class NetworkPublisherTests: XCTestCase {
    
    func testGetExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //        XCTAssertEqual(KpiNetworkManager().text, "Hello, World!")
        // https://swapi.dev/api/starships/9/
        
        
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos/1") to load.")
        let exampleEndpoint = ExampleGetEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/1", method: .get, showDebugInfo: true)
        
        exampleEndpoint.loadDataWithType().subscribe(Subscribers.Sink(receiveCompletion: { result in
            switch result {
            
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            default:
                break
            }
            expectation.fulfill()
        }, receiveValue: { response in
            
       
            print(response)
            XCTAssertEqual(1, response.id)
            
        }))
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testPostExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos") to load.")
        let exampleEndpoint = ExamplePostEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos", method: .post, headers: ["Content-Type": "application/json"],parameters: ["userId": 1, "title": "Prueba", "completed": false], paramEncoding: .JSONEncoding, showDebugInfo: true)
        exampleEndpoint.loadDataWithType().subscribe(Subscribers.Sink(receiveCompletion: { result in
            switch result {
            
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            default:
                break
            }
            expectation.fulfill()
        }, receiveValue: { response in
            
       
            print(response)
            XCTAssertEqual(201, response.id)
            XCTAssertEqual(1, response.userId)
            XCTAssertEqual("Prueba", response.title)
            XCTAssertEqual(false, response.completed)
            
        }))
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testPutExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos") to load.")
        let exampleEndpoint = ExamplePostEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/200", method: .put, headers: ["Content-Type": "application/json"], parameters: ["userId": 1, "title": "Prueba 2", "completed": false], paramEncoding: .JSONEncoding, showDebugInfo: true)
        exampleEndpoint.loadDataWithType().subscribe(Subscribers.Sink(receiveCompletion: { result in
            switch result {
            
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            default:
                break
            }
            expectation.fulfill()
        }, receiveValue: { response in
            
       
            print(response)
            XCTAssertEqual(200, response.id)
            XCTAssertEqual(1, response.userId)
            XCTAssertEqual("Prueba 2", response.title)
            XCTAssertEqual(false, response.completed)
            
        }))
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testPatchTitleExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos") to load.")
        let exampleEndpoint = ExamplePostEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/200", method: .patch, headers: ["Content-Type": "application/json"], parameters: ["title": "Prueba 3"], paramEncoding: .JSONEncoding, showDebugInfo: true)
        exampleEndpoint.loadDataWithType().subscribe(Subscribers.Sink(receiveCompletion: { result in
            switch result {
            
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            default:
                break
            }
            expectation.fulfill()
        }, receiveValue: { response in
            
       
            print(response)
            XCTAssertEqual(200, response.id)
            XCTAssertEqual(10, response.userId)
            XCTAssertEqual("Prueba 3", response.title)
            XCTAssertEqual(false, response.completed)
            
        }))
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testPatchCompletedExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos") to load.")
        let exampleEndpoint = ExamplePostEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/200", method: .patch, headers: ["Content-Type": "application/json"],parameters: ["completed": true], paramEncoding: .JSONEncoding, showDebugInfo: true)
        exampleEndpoint.loadDataWithType().subscribe(Subscribers.Sink(receiveCompletion: { result in
            switch result {
            
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            default:
                break
            }
            expectation.fulfill()
        }, receiveValue: { response in
            
       
            print(response)
            XCTAssertEqual(200, response.id)
            XCTAssertEqual(10, response.userId)
            XCTAssertEqual("ipsam aperiam voluptates qui", response.title)
            XCTAssertEqual(true, response.completed)
            
        }))
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testDeleteExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos/200") to load.")
        let exampleEndpoint = ExampleDeleteEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/200", method: .delete, paramEncoding: .JSONEncoding, showDebugInfo: true)
        exampleEndpoint.loadDataWithType().subscribe(Subscribers.Sink(receiveCompletion: { result in
            switch result {
            
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            default:
                break
            }
            expectation.fulfill()
        }, receiveValue: { response in
            
       
            print(response)
            
            
        }))
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
}
