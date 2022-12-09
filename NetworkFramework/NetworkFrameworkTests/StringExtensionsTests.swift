//
//  StringExtensionsTests.swift
//  NetworkingFrameworkTests
//
//  Created by Aurelian Gavrila on 16.11.2022.
//

import XCTest
@testable import NetworkFramework

class StringExtensionsTests: XCTestCase {

    func test_getMissionDateString_successfuly() throws {
        let date = "2020-03-01T10:20:00.000Z"
        let result = date.getMissionDateString()
        
        XCTAssertEqual(result, "2020-3-1 at 10:20:0")
    }
    
    func test_getMissionDateString_failure() throws {
        let date = "2020-03-01T09:20:00.000Z"
        let result = date.getMissionDateString()
        
        XCTAssertNotEqual(result, "2020-3-1 at 10:20:0")
    }
    
    func test_getMissionDateString_emptyValue() throws {
        let date = "2020-03-01T09:20:00"
        let result = date.getMissionDateString()
        
        XCTAssertEqual(result, "-")
    }
    
    func test_getDateDifference_successfuly() throws {
        let date = "2020-03-01T09:20:00.000Z"
        
        XCTAssertNotNil(date.getDateDifference())
    }
    
    func test_getDateDifference_failure() throws {
        let date = "2020-03-01T09:20:00.00"
        
        XCTAssertNil(date.getDateDifference())
    }

}
