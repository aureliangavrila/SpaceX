//
//  AppCoordinator.swift
//  SpaceX
//
//  Created by Aurelian Gavrila on 14.11.2022.
//

import Foundation
import UIKit
import NetworkFramework

protocol Coordinator {
    init(window: UIWindow?)
    func start()
}

class AppCoordinator: Coordinator {
    private let window: UIWindow?
    private var baseNavigationController: UINavigationController!
    
    required init(window: UIWindow?) {
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        baseNavigationController = UINavigationController()
        baseNavigationController.isNavigationBarHidden = true
        
        let viewModel = LaunchesViewModel(coordinator: self, networkService: NetworkService())
        let launchesVC = LaunchesViewController(viewModel: viewModel)
        
        baseNavigationController.viewControllers = [launchesVC]
        self.window?.rootViewController = baseNavigationController
    }
    
}

extension AppCoordinator: LaunchesViewModelCoordinator {
    func showLaunchDetails(_ launch: Launch) {
        
        let viewModel = LaunchDetailsViewModel(coordinator: self, launch: launch)
        let launchDetailsVC = LaunchDetailsViewController(viewModel: viewModel)
        
        baseNavigationController.pushViewController(launchDetailsVC, animated: true)
    }
}

extension AppCoordinator: LaunchDetailsViewModelCoordinator {
    func popViewController() {
        baseNavigationController.popViewController(animated: true)
    }
}
