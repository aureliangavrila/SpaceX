//
//  LaunchHelper.swift
//  NetworkingFramework
//
//  Created by Aurelian Gavrila on 11.11.2022.
//

import Foundation

public enum LaunchHelper {
    public static func getLaunchImageUrlFor(_ launch: Launch) -> URL? {
        let patch = launch.links.patch
        
        guard let largeImageURL = patch.largeImage else {
            guard let smallImageURL = patch.smallImage else {
                return nil
            }
            
            return URL(string: smallImageURL)
        }
        
        return URL(string: largeImageURL)
    }
    
    public static func getMissionDateFor(_ launch: Launch?) -> Date? {
        guard let launch = launch else { return nil }

        return launch.launchDate.getDate()
    }
    
    public static func getMissionDateStringFor(_ launch: Launch) -> String {
        launch.launchDate.getMissionDateString()
    }
    
    public static func isMissionLaunchedFor(_ launch: Launch) -> Bool {
        guard let numberDaysDifference = launch.launchDate.getDateDifference(), numberDaysDifference > 0  else {
            return false
        }
        
        return  true
    }
    
    public static func getNumberOfDaysSinceFromLaunch(_ launch: Launch) -> Int? {
        launch.launchDate.getDateDifference()
    }
}
