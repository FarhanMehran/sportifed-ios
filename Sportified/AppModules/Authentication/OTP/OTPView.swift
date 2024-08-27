//
//  OTPView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI
enum OTPRoutType{
    case forgetPassword
    case completeProfile
}
struct OTPView: View {
    
    @ObservedObject var viewModel: OTPViewModel
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false){
                VStack{
                    HStack{
                        VStack(alignment: .leading,spacing: 4){
                            
                            Text(StringConstants.verifyCode).font(Font.mulishMedium(size: 28)).foregroundColor(Color.textColor).padding(.top,10)
                            
                            Text(StringConstants.pleaseEntertheCode).font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                            Text("\(viewModel.userPhoneNumber)  dummy\(viewModel.dummyOTP)").font(Font.mulishMedium(size: 15)).foregroundColor(.appGreen)
                            
                            
                        }
                        Spacer()
                    }
                    Image.img_OTP.resizable().frame(width: 200,height: 190).padding(.top,50)
                    
                    ZStack {
                        HStack(spacing: 15) {
                            ForEach(0..<viewModel.otpCode.count, id: \.self) { index in
                                Text(viewModel.getOTPCode(index: index)).font(Font.mulishMedium(size: 24)).frame(width: 79, height: 75)
                                    .background(Color.textFieldColor).foregroundColor(Color.textColor).cornerRadius(15)
                            }
                        }
                        
                        TextField("", text: $viewModel.otpField)
                            .font(Font.mulishMedium(size: 22)).frame(maxHeight: 55).padding(.horizontal, 20).multilineTextAlignment(.center).foregroundColor(.clear).accentColor(.clear).background(Color.clear).keyboardType(.numberPad)
                        
                    }.padding(.top,40)
                    
                    Text(StringConstants.didnReceiveOTP).font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColorGray).padding(.top,30)
                    
                    Text(StringConstants.resendCode).font(Font.mulishMedium(size: 15)).foregroundColor(.appGreen)
                    if viewModel.routType == .forgetPassword{
                        Text(StringConstants.password).font(Font.mulishMedium(size: 18)).padding(.top,25).foregroundColor(Color.textColor).frame(maxWidth: .infinity,alignment: .leading)
                        AuthTextField(title: StringConstants.password,type: .normalField ,text: $viewModel.password).padding(.top,5)
                    }
                    AppButton(title: StringConstants.verify, callBack: {
                        
                        viewModel.btnVerify()
                        
                    }).padding(.top,85)
                }.padding(.horizontal)
            }
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType)
    }
}

#Preview {
    OTPView(viewModel: OTPViewModel())
}
