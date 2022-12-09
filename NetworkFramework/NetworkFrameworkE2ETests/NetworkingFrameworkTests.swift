//
//  NetworkingFrameworkTests.swift
//  NetworkFrameworkTests
//
//  Created by Aurelian Gavrila on 14.11.2022.
//

import XCTest
@testable import NetworkFramework

class NetworkingFrameworkTests: XCTestCase {
    
    func test_getCompanyDetails_successful() throws {
        let sut = NetworkService()
        let expectation = expectation(description: "Correct url returns company details")
        
        sut.getCompanyDetails { (result: Result<Company, NetworkError>) in
            switch result {
            case .success(let company):
                XCTAssertNotNil(company)
            case .failure(_):
                break
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    
    func test_getItems_badResponse() throws {
        let sut = NetworkService()
        let expectation = expectation(description: "Bad url returns bad response error")
        var resultCompany: Company?
        var errorResult: NetworkError?
        
        sut.getItems(url: "v4/company123") { (result: Result<Company, NetworkError>) in
            switch result {
            case .success(let company):
                resultCompany = company
            case .failure(let error):
                errorResult = error
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertNil(resultCompany)
        XCTAssertEqual(errorResult, NetworkError.badResponse)
    }
    
    func test_getItems_badData() throws {
        let sut = NetworkService()
        let expectation = expectation(description: "Bad url returns invalid data error")
        var resultCompany: [Company]?
        var errorResult: NetworkError?
        
        sut.getItems(url: "v4/company") { (result: Result<[Company], NetworkError>) in
            switch result {
            case .success(let company):
                resultCompany = company
            case .failure(let error):
                errorResult = error
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertNil(resultCompany)
        XCTAssertEqual(errorResult, NetworkError.invalidData)
    }

}
