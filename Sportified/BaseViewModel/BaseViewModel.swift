//
//  BaseViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    
    
    lazy var authService = AuthenticationServices()
    lazy var chatService = ChatServices()
    lazy var sportsServices = SportsServices()
    lazy var circketServices = CircketServices()
    lazy var cancellableSet: Set<AnyCancellable> = []
    
    @Published var showActivityIndicator: Bool = false
    @Published var reset = false
    @Published var showProfile = false{
        didSet{
            BaseData.shared.hidebar.toggle()
        }
    }
    @Published var showLoading = false
    @Published var validationAlert: Bool = false
    @Published var toastType: ToastType = .error
    @Published var fullImage: String = ""
    @Published var validationText: String = "1234" {
        didSet {
            if validationText.isEmpty {
                validationAlert = false
            } else {
                validationAlert = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.toastType = .error
            }
        }
    }
}
extension Notification.Name {
    static let myNotification = Notification.Name("myNotification")
}
