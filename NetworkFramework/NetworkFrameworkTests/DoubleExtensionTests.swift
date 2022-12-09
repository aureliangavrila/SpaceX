//
//  DoubleExtensionTests.swift
//  NetworkingFrameworkTests
//
//  Created by Aurelian Gavrila on 16.11.2022.
//

import XCTest
@testable import NetworkFramework

class DoubleExtensionTests: XCTestCase {

    func test_getMissionDateString_successfuly() throws {
        let dataUnix: Double = 1583058000
        let result = dataUnix.getMissionDateString()
        
        XCTAssertEqual(result, "2020-3-1 at 10:20:0")
    }

    func test_getMissionDateString_failure() throws {
        let dataUnix: Double = 158305800
        let result = dataUnix.getMissionDateString()
        
        XCTAssertNotEqual(result, "2020-3-1 at 10:20:0")
    }
    
    func test_getDateDifference_successfuly() throws {
        let dataUnix: Double = 1583058000
        
        XCTAssertNotNil(dataUnix.getDateDifference())
    }
}
