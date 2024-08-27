//
//  OnboardingViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import Foundation
class OnboardingViewModel: BaseViewModel{
    
    var coordinator: AuthCoordinator?
    
    @Published var selectedIndex = 0
    @Published var textHeding = StringConstants.findPlayersYourNeighborhood
    @Published var textDescription = StringConstants.findPlayersBoostyourSportsJourney
    
    func btnClick(){
        if selectedIndex ==  1{
            UserDefaultsManager.shared.loadOnboarding = true
            coordinator?.loadLoginView()
        }
        selectedIndex = 1
        textHeding = StringConstants.findOrganizersYourNeighborhood
        textDescription = StringConstants.findOrganizersBoostYourSportsJourney
    }
 
 
}

