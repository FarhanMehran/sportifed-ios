//
//  AppCoordinator.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import Foundation
import UIKit

// MARK: ViewFactory - Enum
// Standard enum that creates instances of views
public enum ViewFactory {}

// MARK: NavigationActions - Enum
// A list of navigations actions to be handled
// This will need to be refactored because there is a scaling concern

public enum NavigationActions {
    case authentication
}

// MARK: Navigation - Protocol

public protocol Navigation {
    func navigate(navigationActions: NavigationActions)
}

// MARK: Coordinator - Protocol
// All navigtion is managed by this functionality

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

extension Coordinator {
    func setRootViewController(navigationController: UINavigationController) {
        if  let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let windowSceneDelegate = scene.delegate as? SceneDelegate {
            windowSceneDelegate.updateRootViewController(controller: navigationController)
        }
    }
}

