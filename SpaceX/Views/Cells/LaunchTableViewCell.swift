//
//  LaunchTableViewCell.swift
//  SpaceX
//
//  Created by Aurelian Gavrila on 14.11.2022.
//

import UIKit
import Kingfisher
import NetworkFramework

class LaunchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var launchImageView: UIImageView!
    @IBOutlet private weak var missionNameLabel: UILabel!
    @IBOutlet private weak var dateTimeMissionLabel: UILabel!
    @IBOutlet private weak var rocketNameLabel: UILabel!
    @IBOutlet private weak var daysSinceFromNowLabel: UILabel!
    @IBOutlet private weak var daysSinceFromLabel: UILabel!
    @IBOutlet private weak var launchSuccessImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCellWith(_ launch: Launch?) {
        guard let launch = launch else { return }
        
        launchImageView.kf.setImage(with: LaunchHelper.getLaunchImageUrlFor(launch))
        missionNameLabel.text = launch.missionName
        dateTimeMissionLabel.text = LaunchHelper.getMissionDateStringFor(launch)
        rocketNameLabel.text = launch.rocket
        daysSinceFromNowLabel.text = "Days \(LaunchHelper.isMissionLaunchedFor(launch) ? "since" : "from") now:"
        launchSuccessImageView.image = UIImage(systemName: launch.success ?? false ? "checkmark.circle" : "x.circle")
        
        guard let numberDays = LaunchHelper.getNumberOfDaysSinceFromLaunch(launch) else {
            daysSinceFromLabel.text = "-"
            return
        }
        
        daysSinceFromLabel.text = "\(LaunchHelper.isMissionLaunchedFor(launch) ? "- " : "")\(abs(numberDays))"
    }
    
}
