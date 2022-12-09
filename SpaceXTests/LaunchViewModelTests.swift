//
//  LaunchViewModelTests.swift
//  SpaceXTests
//
//  Created by Aurelian Gavrila on 16.11.2022.
//

import XCTest
@testable import NetworkFramework
@testable import SpaceX

fileprivate class LaunchViewModelSpy: LaunchesViewModelCoordinator {
    var showLaunchDetailsCalledCount = 0
    
    func showLaunchDetails(_ launch: Launch) {
        showLaunchDetailsCalledCount += 1
    }
}

class LaunchViewModelTests: XCTestCase {
    
    fileprivate var coordinator: LaunchViewModelSpy!
    fileprivate var sut: LaunchesViewModel!
    fileprivate var networkService: NetworkServiceProtocol!

    override func setUpWithError() throws {
        self.coordinator = LaunchViewModelSpy()
        self.networkService = MockNetworkService()
        self.sut = LaunchesViewModel(coordinator: coordinator, networkService: networkService)
    }

    override func tearDownWithError() throws {
        self.coordinator = nil
        self.networkService = nil
        self.sut = nil
    }

    func test_companyDescription() throws {
        sut.getCompanyDetails()
        
        sut.contentLoaded = { company in
            XCTAssertNotNil(company)
            
            let result = try! XCTUnwrap(company)
            XCTAssertEqual("\(result.name) was founded by \(result.founder) in \(result.year). It has now \(result.numberOfEmployees) employees. \(result.launchSites) launch sites, and is valued at USD \(result.valuation)",
                           "SpaceX was founded by Elon Musk in 2002. It has now 8000 employees. 3 launch sites, and is valued at USD 74000000000")
        }
    }
    
    func test_launchesCount() throws {
        sut.getLaunchesDetails()
        
        XCTAssertTrue(sut.launchesCount > 1)
    }

    func test_getLaunchFor() {
        var result: Launch?
        
        sut.dataLoaded = { [weak self] in
            guard let self = self else { return }
            
            result = self.sut.getLaunchFor(2)
        }
        
        sut.getLaunchesDetails()
        
        XCTAssertEqual(result!.id, "5eb87cdbffd86e000604b32d")
        XCTAssertEqual(result!.missionName, "RatSat")
    }
    
    func test_filterLaunchesBySuccess_successfullMissions() {
        var result: Launch?
        
        sut.dataLoaded = { [weak self] in
            guard let self = self else { return }
            
            let count = self.sut.launchesCount
            let randomIndex = Int.random(in: 0..<count)
            
            result = self.sut.getLaunchFor(randomIndex)
        }
        
        sut.getLaunchesDetails()
        sut.filterLaunchesBySuccess(successful: true)
        
        XCTAssertTrue(result!.success ?? false)
    }
    
    func test_filterLaunchesBySuccess_failedMissions() {
        var result: Launch?
        
        sut.dataLoaded = { [weak self] in
            guard let self = self else { return }

            let count = self.sut.launchesCount
            let randomIndex = Int.random(in: 0..<count)

            result = self.sut.getLaunchFor(randomIndex)
        }
        
        sut.getLaunchesDetails()
        sut.filterLaunchesBySuccess(successful: false)
        
        XCTAssertFalse(result!.success ?? true)
    }

    func test_filterLaunchesByYear_asceding() {
        var resultDate1: Date?
        var resultDate2: Date?
        
        sut.dataLoaded = { [weak self] in
            guard let self = self else { return }

            guard let date1 = LaunchHelper.getMissionDateFor(self.sut.getLaunchFor(1)),
                  let date2 = LaunchHelper.getMissionDateFor(self.sut.getLaunchFor(2)) else {
                      return
                  }

            resultDate1 = date1
            resultDate2 = date2
        }
        
        sut.getLaunchesDetails()
        sut.filterLaunchesByYear(asceding: true)
        
        XCTAssertTrue(resultDate2!.compare(resultDate1!) == .orderedDescending)
    }

    func test_filterLaunchesByYear_descending() {
        var resultDate1: Date?
        var resultDate2: Date?
        
        sut.dataLoaded = { [weak self] in
            guard let self = self else { return }
            
            guard let date1 = LaunchHelper.getMissionDateFor(self.sut.getLaunchFor(1)),
                  let date2 = LaunchHelper.getMissionDateFor(self.sut.getLaunchFor(2)) else {
                      return
                  }
            
            resultDate1 = date1
            resultDate2 = date2
        }
        
        sut.getLaunchesDetails()
        sut.filterLaunchesByYear(asceding: true)
        
        XCTAssertTrue(resultDate2!.compare(resultDate1!) == .orderedDescending)
    }
    
    func test_didSelectLaunchAt() {
        sut.dataLoaded = { [weak self] in
            guard let self = self else { return }
            
            self.sut.didSelectLaunchAt(0)
        }
        sut.getLaunchesDetails()
        
        XCTAssertEqual(coordinator.showLaunchDetailsCalledCount, 1)
    }

}

