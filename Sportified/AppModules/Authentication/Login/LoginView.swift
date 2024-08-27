//
//  LoginView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false){
                VStack{
                    VStack(alignment: .leading){
                        
                        Text(viewModel.title).font(Font.mulishMedium(size: 28)).foregroundColor(Color.textColor).padding(.top,10)
                        
                        
                        VStack(alignment: .leading){
                            ///change heading if view is signup
                            if viewModel.signUpView{
                                
                                HStack{
                                    Text(StringConstants.bySigningUpYouagree).font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                                    Text(StringConstants.termsofService).font(Font.mulishRegular(size: 15)).foregroundColor(.appGreen)
                                }
                                HStack{
                                    Text("and").font(Font.mulishRegular(size: 15)).foregroundColor(.textColorGray)
                                    Text(StringConstants.privacyPolicyUp).font(Font.mulishRegular(size: 15)).foregroundColor(.appGreen)
                                }
                            }else{
                                Text(StringConstants.hiWelcomeBack).font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray).padding(.bottom)
                            }
                            
                        }.frame(height: 20).padding(.top,4)
                        
                        Text(StringConstants.email).font(Font.mulishMedium(size: 18)).padding(.top,55).foregroundColor(Color.textColor)
                        AuthTextField(title: StringConstants.exampleGmail,type: .normalField, keyboardType: .emailAddress ,text: $viewModel.txtEmail)
                        
                        Text(StringConstants.password).font(Font.mulishMedium(size: 18)).padding(.top,18).foregroundColor(Color.textColor)
                        AuthTextField(title: StringConstants.stars,type:viewModel.showPassword ? .normalField : .secureField ,isPassword: viewModel.showPassword, text: $viewModel.txtPassword) {
                            viewModel.showPassword.toggle()
                        }
                        
                        ///change forgotPassword button if view is signup
                        HStack{
                            if viewModel.signUpView{
                                CheckButton()
                                Text(StringConstants.agreewithTermsConditions).font(Font.mulishMedium(size: 14)).foregroundColor(.textColor)
                                Text(StringConstants.TermsConditions).font(Font.mulishMedium(size: 14)).foregroundColor(.appGreen)
                            }
                            Spacer()
                            if !viewModel.signUpView{
                                Text(StringConstants.forgotPassword).font(Font.mulishRegular(size: 15)).foregroundColor(.appGreen).onTapGesture {
                                    viewModel.coordinator?.loadForgetPasswordView()
                                }
                            }
                        }.frame(height: 20).padding(.top,5)
                        
                        AppButton(title: !viewModel.signUpView ? StringConstants.signIn  :StringConstants.signUp, callBack: {
                            viewModel.validationLogin()
                            
                        }).padding(.top,45)
                        
                    }
                    
                    DashLineView(text: viewModel.signUpWith).padding(.top,35)
                    
                    Image.ic_Google.resizable().frame(width: 70,height: 70).padding(.top,45)
                    
                    Spacer()
                    
                    HStack{
                        Text(viewModel.haveAccoutn).font(Font.mulishRegular(size: 18)).foregroundColor(Color.textColor)
                        Text(viewModel.signUpView ? StringConstants.signIn  :StringConstants.signUp).font(Font.mulishRegular(size: 18)).foregroundColor(Color.appGreen)
                    }.padding(.top,45).onTapGesture {
                        viewModel.changeConfigationSignUpView()
                        
                    }
                    
                }.padding(.horizontal)
                    .showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType)
            }
            
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
            
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
