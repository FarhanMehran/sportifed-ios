//
//  AccountViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import Foundation
class AccountViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    init(coordinator: HomeCoordinator? = nil) {
        self.coordinator = coordinator
    }
}
