//
//  ViewModel.swift
//  SpaceX
//
//  Created by Aurelian Gavrila on 14.11.2022.
//

import Foundation
import NetworkFramework

protocol LaunchesViewModelCoordinator {
    func showLaunchDetails(_ launch: Launch)
}

protocol LaunchesViewModelProtocol {
    var sectionsCount: Int { get }
    var launchesCount: Int { get }
    var contentLoaded: ((Company?) -> ())? { get set }
    var dataLoaded: (() -> ())? { get set }
    func getLaunchFor(_ index: Int) -> Launch?
    func didSelectLaunchAt(_ index: Int)
    func filterLaunchesBySuccess(successful: Bool)
    func filterLaunchesByYear(asceding: Bool)
    func getCompanyDetails()
    func getLaunchesDetails()
}

final class LaunchesViewModel: BaseViewModel<LaunchesViewModelCoordinator>, LaunchesViewModelProtocol {
    
    var sectionsCount: Int {
        return 1
    }
    
    var launchesCount: Int {
        return filteredLaunches.count
    }
    
    var contentLoaded: ((Company?) -> ())?
    var dataLoaded: (() -> ())?
    private lazy var filteredLaunches = [Launch]() {
        didSet {
            dataLoaded?()
        }
    }
    private var launches = [Launch]() {
        didSet {
            filteredLaunches = launches
        }
    }
    
    let networkService: NetworkServiceProtocol
    
    init(coordinator: LaunchesViewModelCoordinator, networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        super.init(coordinator: coordinator)
    }
    
    func getLaunchFor(_ index: Int) -> Launch? {
        return filteredLaunches[safe: index]
    }
    
    func didSelectLaunchAt(_ index: Int) {
        guard let launch = getLaunchFor(index) else { return }
        
        coordinator.showLaunchDetails(launch)
    }
    
    func filterLaunchesBySuccess(successful: Bool) {
        filteredLaunches = launches.filter {
            guard let success = $0.success else { return false }
            
            return successful ? success : !success
        }
    }
    
    func filterLaunchesByYear(asceding: Bool) {
        filteredLaunches = launches.sorted(by: { firstLaunch, secondLaunch in
            guard let firstDate = LaunchHelper.getMissionDateFor(firstLaunch), let secondDate = LaunchHelper.getMissionDateFor(secondLaunch) else { return false }
            
            return asceding ? firstDate.compare(secondDate) == .orderedAscending : firstDate.compare(secondDate) == .orderedDescending
        })
    }
    
    func getCompanyDetails() {
        self.networkService.getCompanyDetails { [weak self] (result: Result<Company, NetworkError>) in
            switch result {
            case .success(let company):
                self?.contentLoaded?(company)
            case .failure(let error):
                self?.contentLoaded?(nil)
                print(error.localizedDescription)
            }
        }
    }
    
    func getLaunchesDetails() {
        self.networkService.getLaunches { [weak self] (result: Result<[Launch], NetworkError>) in
            switch result {
            case .success(let launches):
                self?.launches = launches
            case .failure(let error):
                self?.launches = []
                print(error.localizedDescription)
            }
        }
    }
}
