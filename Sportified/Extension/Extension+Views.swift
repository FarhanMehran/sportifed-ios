//
//  Extension+Views.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import SwiftUI

//MARK: - View Extension
extension View {
    
    /**Hiding Keyboard from View*/
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) } else { self }
    }
    
    func showToast(toastText: String, isShowing: Binding<Bool>, toastType: ToastType = .error) -> some View {
        self.modifier(ToastModifier(toastText: toastText, toastType: toastType ,showToast: isShowing))
    }
    
    func signupExpandedCardView() -> some View {
        modifier(SignupExpanedCardView())
    }
}


