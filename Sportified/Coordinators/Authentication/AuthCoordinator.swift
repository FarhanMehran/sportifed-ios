//
//  AuthCoordinator.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import Foundation
import UIKit
public class AuthCoordinator {
    
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
     //   loadHomeView()
     SplashScreen()
      //  loadOTPView(dummyOTP: "")
      //  loadCompleteProfileView()
    }
    
    func popNavigationView() {
        navigationController.popViewController(animated: true)
    }
    
    func SplashScreen() {
        let viewModel = SplashViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Authentication.splashScreen(viewModel: viewModel).viewController
        navigationController.viewControllers = [viewController]
    }
    
    func loadLoginView(){
        let viewModel = LoginViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Authentication.loginView(viewModel: viewModel).viewController
        navigationController.viewControllers = [viewController]
       // navigationController.pushViewController(viewController, animated: true)
    }
    
    
    func loadLoginViewForgetPassword(){
        let viewModel = LoginViewModel()
        viewModel.coordinator = self
        viewModel.signUpView = true
        let viewController = ViewFactory.Authentication.loginView(viewModel: viewModel).viewController
        navigationController.viewControllers = [viewController]
      
    }

    func loadCompleteProfileView(){
        let viewModel = CompleteProfileViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Authentication.completeProfileView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func loadOTPView(userPhoneNumber: String, dummyOTP: String, routType: OTPRoutType = .forgetPassword){
        let viewModel = OTPViewModel()
        viewModel.coordinator = self
        viewModel.dummyOTP = dummyOTP
        viewModel.routType = routType
        viewModel.userPhoneNumber = userPhoneNumber
        let viewController = ViewFactory.Authentication.otpView(viewModel: viewModel).viewController
       navigationController.pushViewController(viewController, animated: true)
    }
    
    func loadForgetPasswordView(){
        let viewModel = ForgetPasswordViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Authentication.forgetPasswordView(viewModel: viewModel).viewController
       navigationController.pushViewController(viewController, animated: true)
    }
    
    func loadOnboardingView(){
        let viewModel = OnboardingViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Authentication.onboardingView(viewModel: viewModel).viewController
        navigationController.viewControllers = [viewController]
    }
    
    func loadHomeView() {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
        homeCoordinator.parentCoordinator = self
        homeCoordinator.start()
    }
}


