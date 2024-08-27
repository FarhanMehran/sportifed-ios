//
//  AuthViewFactoryEnums.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import Foundation
import UIKit
import SwiftUI

extension ViewFactory {
    
    enum Authentication {
        case splashScreen(viewModel: SplashViewModel)
        case loginView(viewModel: LoginViewModel)
        case completeProfileView(viewModel: CompleteProfileViewModel)
        case otpView(viewModel: OTPViewModel)
        case onboardingView(viewModel: OnboardingViewModel)
        case forgetPasswordView(viewModel: ForgetPasswordViewModel)

    
        var viewController: UIViewController {
            switch self {
            case .splashScreen(let viewModel):
                return UIHostingController(rootView: SplashView(viewModel: viewModel))
            case .loginView(let viewModel):
                return UIHostingController(rootView: LoginView(viewModel: viewModel))
            case .completeProfileView(let viewModel):
                return UIHostingController(rootView: CompleteProfileView(viewModel: viewModel))
            case .otpView(let viewModel):
                return UIHostingController(rootView: OTPView(viewModel: viewModel))
            case .onboardingView(let viewModel):
                return UIHostingController(rootView: OnboardingView(viewModel: viewModel))
            case .forgetPasswordView(let viewModel):
                return UIHostingController(rootView: ForgetPasswordView(viewModel: viewModel))
            }
        }
    }
}
