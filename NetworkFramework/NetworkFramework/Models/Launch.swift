//
//  Launch.swift
//  NetworkingFramework
//
//  Created by Aurelian Gavrila on 11.11.2022.
//

import Foundation

public struct Patch: Codable {
    private enum CodingKeys: String, CodingKey {
        case smallImage = "small"
        case largeImage = "large"
    }
    
    public let smallImage: String?
    public let largeImage: String?
}

public struct Links: Codable {
    public let presskit: String?
    public  let article: String?
    public let wikipedia: String?
    public let patch: Patch
}

public struct Launch: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, rocket, upcoming, success, links
        case missionName = "name"
        case missionDate = "static_fire_date_utc"
        case missionDateUnix = "static_fire_date_unix"
        case launchDate = "date_utc"
        case launchDateToBeDiscussed = "tbd"
    }
    
    public let id: String
    public let missionName: String
    public let missionDate: String?
    public let missionDateUnix: Double?
    public let rocket: String
    public let launchDate: String
    public let upcoming: Bool
    public let launchDateToBeDiscussed: Bool
    public let success: Bool?
    public let links: Links
}
