//
//  LaunchDetailsViewModelTests.swift
//  SpaceXTests
//
//  Created by Aurelian Gavrila on 16.11.2022.
//

import XCTest
@testable import NetworkFramework
@testable import SpaceX

fileprivate class LaunchDetailsViewModelSpy: LaunchDetailsViewModelCoordinator {
    var popViewControllerCalled = 0
    
    func popViewController() {
        popViewControllerCalled += 1
    }
}

class LaunchDetailsViewModelTests: XCTestCase {

    fileprivate var coordinator: LaunchDetailsViewModelSpy!

    override func setUpWithError() throws {
        self.coordinator = LaunchDetailsViewModelSpy()
    }
    
    override func tearDownWithError() throws {
        self.coordinator = nil
    }

    func test_launchArticleUrl_notNil() throws {
        let luanch = Launch(id: "5eb87d42ffd86e000604b384",
                                   missionName: "CRS-20",
                                   missionDate: "2020-03-01T10:20:00.000Z",
                                   missionDateUnix: 1583058000,
                                   rocket: "5e9d0d95eda69973a809d1ec",
                                   launchDate: "2020-03-07T04:50:31.000Z",
                                   upcoming: false, launchDateToBeDiscussed: false, success: true,
                                   links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/SpaceX_CRS-20",
                                                patch: Patch(smallImage: "https://images2.imgbox.com/53/22/dh0XSLXO_o.png",
                                                             largeImage: "https://images2.imgbox.com/15/2b/NAcsTEB6_o.png")))
        
        let sut = LaunchDetailsViewModel(coordinator: self.coordinator, launch: luanch)
        
        XCTAssertNotNil(sut.launchArticleUrl)
        XCTAssertEqual(sut.launchArticleUrl, "https://en.wikipedia.org/wiki/SpaceX_CRS-20")
    }
    
    func test_launchArticleUrl_nil() throws {
        let luanch = Launch(id: "5eb87d42ffd86e000604b384",
                                   missionName: "CRS-20",
                                   missionDate: "2020-03-01T10:20:00.000Z",
                                   missionDateUnix: 1583058000,
                                   rocket: "5e9d0d95eda69973a809d1ec",
                                   launchDate: "2020-03-07T04:50:31.000Z",
                                   upcoming: false, launchDateToBeDiscussed: false, success: true,
                                   links: Links(presskit: nil, article: nil, wikipedia: nil,
                                                patch: Patch(smallImage: "https://images2.imgbox.com/53/22/dh0XSLXO_o.png",
                                                             largeImage: "https://images2.imgbox.com/15/2b/NAcsTEB6_o.png")))
        
        let sut = LaunchDetailsViewModel(coordinator: self.coordinator, launch: luanch)
        XCTAssertNil(sut.launchArticleUrl)
    }
    
    func test_dismissScreen() throws {
        let launch = Launch(id: "5eb87d42ffd86e000604b384",
                                   missionName: "CRS-20",
                                   missionDate: "2020-03-01T10:20:00.000Z",
                                   missionDateUnix: 1583058000,
                                   rocket: "5e9d0d95eda69973a809d1ec",
                                   launchDate: "2020-03-07T04:50:31.000Z",
                                   upcoming: false, launchDateToBeDiscussed: false, success: true,
                                   links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/SpaceX_CRS-20",
                                                patch: Patch(smallImage: "https://images2.imgbox.com/53/22/dh0XSLXO_o.png",
                                                             largeImage: "https://images2.imgbox.com/15/2b/NAcsTEB6_o.png")))
        
        let sut = LaunchDetailsViewModel(coordinator: self.coordinator, launch: launch)
        sut.dismissScreen()
        
        XCTAssertEqual(coordinator.popViewControllerCalled, 1)
    }

}

