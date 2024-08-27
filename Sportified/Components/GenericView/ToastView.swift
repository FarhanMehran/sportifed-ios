//
//  ToastView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import SwiftUI

struct ToastView: View {
    
    let toastText: String
    var toastType:ToastType
    @Binding var showToast: Bool
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .top) {
                //if toastType == .error{
                Image(systemName: toastType == .success ? "checkmark.seal" : "info.circle.fill").font(Font.mulishRegular(size: 20)).foregroundColor(Color.white)
                        .onTapGesture {
                            self.showToast = false
                        }
               // }
                Text(toastText)
                    .font(Font.mulishRegular(size: 16))
                    .foregroundColor(Color.white)
                    .shadow(radius: 1).offset(y: 1)
            }.padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(Color(toastType.rawValue))
                .cornerRadius(24)
                .shadow(radius: 10)
            
        }.padding(20).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom).onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showToast = false
            }
        }
    }
}

#Preview {
    ToastView(toastText: "sdfnsdklnfmklsdnf", toastType: .success, showToast: .constant(true))
}

struct ToastModifier: ViewModifier {
    
    let toastText: String
    var toastType:ToastType = .error
    @Binding var showToast: Bool
    
    func body(content: Content) -> some View {
        
        ZStack(alignment: .top) {
            content
            
            if showToast {
                ToastView(toastText: toastText, toastType: toastType, showToast: $showToast)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.3))
            }
        }
    }
}
