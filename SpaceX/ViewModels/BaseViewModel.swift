//
//  BaseViewModel.swift
//  SpaceX
//
//  Created by Aurelian Gavrila on 15.11.2022.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype C
    var coordinator: C { get }
}

class BaseViewModel<C>: ViewModelProtocol {
    private (set) var coordinator: C
    
    init(coordinator: C) {
        self.coordinator = coordinator
    }
}
