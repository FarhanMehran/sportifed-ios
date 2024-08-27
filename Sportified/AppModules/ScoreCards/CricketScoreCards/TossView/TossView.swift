//
//  TossView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 18/07/2024.
//

import SwiftUI

struct TossView: View {
    @ObservedObject var viewModel: TossViewModel
    var body: some View {
        ZStack{
            VStack{
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator,title: "Toss",showUndoButton: true, btnShareCallBack:  {
                    
                }).padding(.top,5)
                VStack{
                    ScrollView{
                        VStack(alignment: .leading){
                            Text("Who won the toss?").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,20)
                            HStack(spacing: 50){
                                VStack(spacing: 10){
                                    HStack{
                                        WebImageView(image: viewModel.nearbyMatchesitem?.teams?.first?.img ?? "Team A",placeholder: Image("Hard"))
                                            .frame(width: 100,height: 100)
                                    }.frame(width: 80,height: 80)
                                        .background(Color.appGray)
                                        .clipShape(.circle)
                                    Text(viewModel.nearbyMatchesitem?.teams?.first?.name ?? "Team A") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0))
                                }.frame(width: 140,height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appGray, lineWidth: 1))
                                .background(viewModel.tosswinnerid == 0 ? Color.appGreenColor : .clear).cornerRadius(10)
                                .onTapGesture {
                                    viewModel.tosswinnerid = 0
                                }
                                
                                VStack(spacing: 10){
                                    HStack{
                                        WebImageView(image: viewModel.nearbyMatchesitem?.teams?.first?.img ?? "Team A",placeholder: Image("Hard"))
                                            .frame(width: 100,height: 100)
                                    }.frame(width: 80,height: 80).background( Color.appGray).clipShape(.circle)
                                    Text(viewModel.nearbyMatchesitem?.teams?.last?.name ?? "Team B") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0))
                                }.frame(width: 140,height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appGray, lineWidth: 1))
                                .background(viewModel.tosswinnerid == 1 ? Color.appGreenColor : .clear).cornerRadius(10)
                                .onTapGesture {
                                    viewModel.tosswinnerid = 1
                                }
                                
                            }.padding(.top)
                            Text("Winner of the toss elected to?").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,20)
                            HStack(spacing: 50){
                                VStack(spacing: 10){
                                    HStack{
                                        Image("fi_15617810")
                                    }.frame(width: 80,height: 80).background(Color.appGreenColor).clipShape(.circle)
                                    Text("Bat") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0))
                                }.frame(width: 140,height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appGray, lineWidth: 1))
                                .background(viewModel.tossdecision == 0 ? Color.appGreenColor : .clear).cornerRadius(10)
                                .onTapGesture {
                                    viewModel.tossdecision = 0
                                }
                                
                                VStack(spacing: 10){
                                    HStack{
                                        Image("Group")
                                    }.frame(width: 80,height: 80).background(Color.appGreenColor).clipShape(.circle)
                                    Text("Bowl") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0))
                                }.frame(width: 140,height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appGray, lineWidth: 1))
                                .background(viewModel.tossdecision == 1 ? Color.appGreenColor : .clear).cornerRadius(10)
                                .onTapGesture {
                                    viewModel.tossdecision = 1
                                }
                                
                            }.padding(.top)
                            
                            
                        }
                        
                    }
                    Spacer()
                    AppButton(title: "Let’s Play", callBack: {
                        
                        //viewModel.test()
                        viewModel.btnStartMatchClick()
                    }).padding(.top).padding(.horizontal)
                }
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType)
    }
}

#Preview {
    TossView(viewModel: TossViewModel())
}

