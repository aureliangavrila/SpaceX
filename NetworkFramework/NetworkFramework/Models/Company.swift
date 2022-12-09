//
//  Company.swift
//  NetworkingFramework
//
//  Created by Aurelian Gavrila on 11.11.2022.
//

import Foundation

public struct Company: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, name, founder, valuation
        case year = "founded"
        case numberOfEmployees = "employees"
        case launchSites = "launch_sites"
    }
    
    public let id: String
    public let name: String
    public let founder: String
    public let year: Int
    public  let numberOfEmployees: Int
    public let launchSites: Int
    public let valuation:  Int
}
