//
//  ForgetPasswordView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @ObservedObject var viewModel: ForgetPasswordViewModel
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false){
                VStack{
                    HStack{
                        Button {
                            viewModel.coordinator?.popNavigationView()
                        } label: {
                            Image.ic_ArrowBack.padding(.top)
                        }
                        Spacer()
                    }
                    
                    VStack(alignment: .leading,spacing: 5){
                        
                        Text(StringConstants.forgetPassword).font(Font.mulishMedium(size: 28)).foregroundColor(Color.textColor).padding(.top,15)
                        Text(StringConstants.typeYourRegisterEmail).font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                        Text(StringConstants.email).font(Font.mulishMedium(size: 18)).padding(.top,45).foregroundColor(Color.textColor)
                        AuthTextField(title: StringConstants.exampleGmail,type: .normalField ,text: $viewModel.email).padding(.top,5)
                        
                        AppButton(title: StringConstants.resetPassword, callBack: {
                            viewModel.btnForget()
                           
                        }).padding(.top,145)
                    }
                }.padding(.horizontal)
            }
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert)
    }
}

#Preview {
    ForgetPasswordView(viewModel: ForgetPasswordViewModel())
}
