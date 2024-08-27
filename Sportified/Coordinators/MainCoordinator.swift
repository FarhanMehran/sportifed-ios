//
//  MainCoordinator.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import Foundation
import SwiftUI

// MARK: - The Root Coordinator
class MainCoordinator: Coordinator, Navigation {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
       
    }
    
    func start() {
       
        loadLoginView()
    }
    
    func navigate(navigationActions: NavigationActions) {
        switch navigationActions {
        case .authentication:
            loadLoginView()
        }
    }
    
    func loadLoginView() {
        let authCoordinator = AuthCoordinator(navigationController: self.navigationController)
        setRootViewController(navigationController: navigationController)
        authCoordinator.start()
    }
    
    func removeAllCoordinators() {
        guard !childCoordinators.isEmpty else { return }
        childCoordinators.removeAll()
    }
    
}



