//
//  LaunchDetailsViewModel.swift
//  SpaceX
//
//  Created by Aurelian Gavrila on 15.11.2022.
//

import Foundation
import NetworkFramework

protocol LaunchDetailsViewModelProtocol {
    var launchArticleUrl: String? { get }
    func dismissScreen()
}

protocol LaunchDetailsViewModelCoordinator {
    func popViewController()
}

final class LaunchDetailsViewModel: BaseViewModel<LaunchDetailsViewModelCoordinator>, LaunchDetailsViewModelProtocol {
    
    var launchArticleUrl: String? {
        let links = launch.links
        
        var stringUrl = links.wikipedia ?? links.article
        stringUrl = stringUrl ?? links.presskit
        
        return stringUrl
    }
    
    private let launch: Launch
    
    init(coordinator: LaunchDetailsViewModelCoordinator, launch: Launch) {
        self.launch = launch
        super.init(coordinator: coordinator)
    }
    
    func dismissScreen() {
        coordinator.popViewController()
    }
}
