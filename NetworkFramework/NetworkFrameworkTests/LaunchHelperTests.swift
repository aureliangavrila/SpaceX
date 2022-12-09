//
//  LaunchHelperTests.swift
//  NetworkingFrameworkTests
//
//  Created by Aurelian Gavrila on 16.11.2022.
//

import XCTest
@testable import NetworkFramework

class LaunchHelperTests: XCTestCase {

    func test_getLaunchImageUrlFor_successfulForLargeImage() throws {
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
        
        let result = LaunchHelper.getLaunchImageUrlFor(launch)
        
        XCTAssertEqual(result, URL(string: "https://images2.imgbox.com/15/2b/NAcsTEB6_o.png"))
    }
    
    func test_getLaunchImageUrlFor_successfulForSmallImage() throws {
        let launch = Launch(id: "5eb87d42ffd86e000604b384",
                         missionName: "CRS-20",
                         missionDate: "2020-03-01T10:20:00.000Z",
                         missionDateUnix: 1583058000,
                         rocket: "5e9d0d95eda69973a809d1ec",
                         launchDate: "2020-03-07T04:50:31.000Z",
                         upcoming: false, launchDateToBeDiscussed: false, success: true,
                         links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/SpaceX_CRS-20",
                                      patch: Patch(smallImage: "https://images2.imgbox.com/53/22/dh0XSLXO_o.png",
                                                   largeImage: nil)))
        
        let result = LaunchHelper.getLaunchImageUrlFor(launch)
        
        XCTAssertEqual(result, URL(string: "https://images2.imgbox.com/53/22/dh0XSLXO_o.png"))
    }
    
    func test_getLaunchImageUrlFor_failure() throws {
        let launch = Launch(id: "5eb87d42ffd86e000604b384",
                         missionName: "CRS-20",
                         missionDate: "2020-03-01T10:20:00.000Z",
                         missionDateUnix: 1583058000,
                         rocket: "5e9d0d95eda69973a809d1ec",
                         launchDate: "2020-03-07T04:50:31.000Z",
                         upcoming: false, launchDateToBeDiscussed: false, success: true,
                         links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/SpaceX_CRS-20",
                                      patch: Patch(smallImage: nil,
                                                   largeImage: nil)))
        
        let result = LaunchHelper.getLaunchImageUrlFor(launch)
        
        XCTAssertEqual(result, nil)
    }
    
    func test_getMissionDateFor_successful() throws {
        let launch = Launch(id: "5eb87d42ffd86e000604b384",
                         missionName: "CRS-20",
                         missionDate: "2020-03-01T10:20:00.000Z",
                         missionDateUnix: 1583058000,
                         rocket: "5e9d0d95eda69973a809d1ec",
                         launchDate: "2020-03-07T04:50:31.000Z",
                         upcoming: false, launchDateToBeDiscussed: false, success: true,
                         links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/SpaceX_CRS-20",
                                      patch: Patch(smallImage: nil,
                                                   largeImage: nil)))
        
        let result = LaunchHelper.getMissionDateFor(launch)
        
        XCTAssertNotNil(result)
    }
    
    func test_getMissionDateFor_failure() throws {
        let launch = Launch(id: "5eb87d42ffd86e000604b384",
                         missionName: "CRS-20",
                         missionDate: "2020-03-01T10:20:00.000Z",
                         missionDateUnix: nil,
                         rocket: "5e9d0d95eda69973a809d1ec",
                         launchDate: "2020-03-07T04:50:31.00",
                         upcoming: false, launchDateToBeDiscussed: false, success: true,
                         links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/SpaceX_CRS-20",
                                      patch: Patch(smallImage: nil,
                                                   largeImage: nil)))
        
        let result = LaunchHelper.getMissionDateFor(launch)
        
        XCTAssertNil(result)
    }
    
    func test_getMissionDateStringFor_successful() throws {
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
        
        let result = LaunchHelper.getMissionDateStringFor(launch)
        
        XCTAssertEqual(result, "2020-3-7 at 4:50:31")
    }
    
    func test_isMissionLaunchedFor_successful() throws {
        let launch = Launch(id: "5eb87d42ffd86e000604b384",
                         missionName: "CRS-20",
                         missionDate: "2020-03-01T10:20:00.000Z",
                         missionDateUnix: 1583058000,
                         rocket: "5e9d0d95eda69973a809d1ec",
                         launchDate: "2020-03-07T04:50:31.000Z",
                         upcoming: false, launchDateToBeDiscussed: true, success: true,
                         links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/SpaceX_CRS-20",
                                      patch: Patch(smallImage: "https://images2.imgbox.com/53/22/dh0XSLXO_o.png",
                                                   largeImage: "https://images2.imgbox.com/15/2b/NAcsTEB6_o.png")))
        
        let result = LaunchHelper.isMissionLaunchedFor(launch)
        
        XCTAssertEqual(result, true)
    }
    
    func test_isMissionLaunchedFor_failure() throws {
        let launch = Launch(id: "5eb87d42ffd86e000604b384",
                         missionName: "CRS-20",
                         missionDate: "2020-03-01T10:20:00.000Z",
                         missionDateUnix: 1583058000,
                         rocket: "5e9d0d95eda69973a809d1ec",
                         launchDate: "2022-12-25T04:50:31.000Z",
                         upcoming: false, launchDateToBeDiscussed: false, success: true,
                         links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/SpaceX_CRS-20",
                                      patch: Patch(smallImage: "https://images2.imgbox.com/53/22/dh0XSLXO_o.png",
                                                   largeImage: "https://images2.imgbox.com/15/2b/NAcsTEB6_o.png")))
        
        let result = LaunchHelper.isMissionLaunchedFor(launch)
        
        XCTAssertEqual(result, false)
    }
    
    func test_getNumberOfDaysSinceFromLaunch() throws {
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
        
        let result = LaunchHelper.getNumberOfDaysSinceFromLaunch(launch)
        
        XCTAssertNotNil(result)
    }
}
