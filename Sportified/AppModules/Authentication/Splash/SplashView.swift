//
//  SplashView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        ZStack{
            Color.appGreenColor.edgesIgnoringSafeArea(.all)
            Image.ic_appLogo.resizable().frame(width: 160,height: 200)
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                WebSocketManager.shared.connect()
                if UserDefaultsManager.shared.loadOnboarding ?? false{
                  
                        if UserDefaultsManager.shared.authToken != nil{
                           // if Reachability.isConnectedToNetwork(){
                                viewModel.coordinator?.loadHomeView()
                           // }
                            return
                        }
                        viewModel.coordinator?.loadLoginView()
                   
                }else{
                    viewModel.coordinator?.loadOnboardingView()
                    
                }
                
            }
            
            
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel())
}
