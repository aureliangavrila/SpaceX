//
//  MockNetworkService.swift
//  SpaceXTests
//
//  Created by Aurelian on 17.11.2022.
//

import Foundation
@testable import NetworkFramework


class MockNetworkService: NetworkServiceProtocol {
    
    func getCompanyDetails(completionHandler: @escaping (Result<Company, NetworkError>) -> Void) {
        let comapany = Company(id: "5eb75edc42fea42237d7f3ed", name: "SpaceX", founder: "Elon Musk", year: 2002, numberOfEmployees: 8000, launchSites: 3, valuation: 74000000000)
        
        completionHandler(.success(comapany))
    }
    
    
    func getLaunches(completionHandler: @escaping (Result<[Launch], NetworkError>) -> Void) {
        let launches = getLaunches()
        
        completionHandler(.success(launches))
    }
    
    private func getLaunches() -> [Launch] {
        return [
            Launch(id: "5eb87cd9ffd86e000604b32a",
                   missionName: "FalconSat",
                   missionDate: "2006-03-17T00:00:00.000Z",
                   missionDateUnix: 1142553600.0,
                   rocket: "5e9d0d95eda69955f709d1eb",
                   launchDate: "2006-03-24T22:30:00.000Z",
                   upcoming: false, launchDateToBeDiscussed: false, success: false,
                   links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/DemoSat",
                                patch: Patch(smallImage: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png",
                                             largeImage: "https://images2.imgbox.com/5b/02/QcxHUb5V_o.png"))),
            
            Launch(id: "5eb87cdaffd86e000604b32b",
                   missionName: "DemoSat",
                   missionDate: nil,
                   missionDateUnix: nil,
                   rocket: "5e9d0d95eda69955f709d1eb",
                   launchDate: "2007-03-21T01:10:00.000Z",
                   upcoming: false, launchDateToBeDiscussed: false, success: false,
                   links: Links(presskit: nil, article: "https://www.space.com/3590-spacex-falcon-1-rocket-fails-reach-orbit.html", wikipedia: "https://en.wikipedia.org/wiki/DemoSat",
                                patch: Patch(smallImage: "https://images2.imgbox.com/f9/4a/ZboXReNb_o.png",
                                             largeImage: "https://images2.imgbox.com/80/a2/bkWotCIS_o.png"))),
            
            Launch(id: "5eb87cdbffd86e000604b32d",
                   missionName: "RatSat",
                   missionDate: "2008-09-20T00:00:00.000Z",
                   missionDateUnix: 1221868800.0,
                   rocket: "5e9d0d95eda69955f709d1eb",
                   launchDate: "2008-09-28T23:15:00.000Z",
                   upcoming: false, launchDateToBeDiscussed: false, success: true,
                   links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/Ratsat",
                                patch: Patch(smallImage: "https://images2.imgbox.com/95/39/sRqN7rsv_o.png",
                                             largeImage: nil))),
            
            Launch(id: "5eb87cdcffd86e000604b32e",
                   missionName: "RazakSat",
                   missionDate: "2008-09-20T00:00:00.000Z",
                   missionDateUnix: 1221868800.0,
                   rocket: "5e9d0d95eda69955f709d1eb",
                   launchDate: "2009-07-13T03:35:00.000Z",
                   upcoming: false, launchDateToBeDiscussed: false, success: true,
                   links: Links(presskit: nil, article: nil, wikipedia: "https://en.wikipedia.org/wiki/RazakSAT",
                                patch: Patch(smallImage: nil,
                                             largeImage: "https://images2.imgbox.com/92/e4/7Cf6MLY0_o.png")))
        ]
    }
}
