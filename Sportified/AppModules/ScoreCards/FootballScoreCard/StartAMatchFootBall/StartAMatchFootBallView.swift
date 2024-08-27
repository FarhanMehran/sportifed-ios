//
//  StartAMatchFootBall.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/07/2024.
//

import SwiftUI

struct StartAMatchFootBallView: View {
    var favoriteSportsList = ["Rough", "Cement","Turf","Astroturf","Matting"]
    var ballType = ["Tennis", "Leather","Hard","Other"]
    var isSelectItem = 1
    @ObservedObject var viewModel: StartAMatchFootBallViewModel
    var body: some View {
        
        ZStack{
            VStack{
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator ,title: "Start a Match",showUndoButton: true, btnShareCallBack:  {
                    
                }).padding(.top,5)
                ScrollView{
                    HStack{
                        VStack{
                            HStack{
                                WebImageView(image: viewModel.nearbyMatchesitem?.teams?.first?.img ?? "Team A",placeholder: Image("Hard"))
                                    .frame(width: 100,height: 100)
                            }.frame(width: 100,height: 100).background(Color.appGray).clipShape(.circle)
                            
                            ListButton(title: viewModel.nearbyMatchesitem?.teams?.first?.name ?? "Team A", callBack: {}).padding(.horizontal)
                        }
                        Image.ic_vs.padding(.bottom,30)
                        VStack{
                            HStack{
                                WebImageView(image: viewModel.nearbyMatchesitem?.teams?.last?.img ?? "Team A",placeholder: Image("Hard"))
                                    .frame(width: 100,height: 100)
                            }.frame(width: 100,height: 100).background(Color.appGray).clipShape(.circle)
                            
                            ListButton(title: viewModel.nearbyMatchesitem?.teams?.last?.name ?? "Team b", callBack: {}).padding(.horizontal)
                        }
                        
                    }.padding(.top,30)
                    VStack(alignment: .leading){
                        HStack(spacing: 2){
                            Text("Match Type").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,25)
                        HStack(spacing:10){
                            ListButton2(title: "20 Minutes",
                                        bgColor: viewModel.selectedMatchTime == .time_20 ? .appGreenColor : .textFieldColor, foregroundColor: viewModel.selectedMatchTime == .time_20 ? .white : .textColor,cornerRadius: 20 ,callBack: {
                                viewModel.selectedMatchTime = .time_20
                            })
                            ListButton2(title: "30 Minutes",
                                        bgColor:viewModel.selectedMatchTime == .time_30 ? .appGreenColor : .textFieldColor,foregroundColor:viewModel.selectedMatchTime == .time_30 ? .white : .textColor,cornerRadius: 20 ,callBack: {
                                viewModel.selectedMatchTime = .time_30
                            })
                            ListButton2(title: "60 Minutes",
                                        bgColor:viewModel.selectedMatchTime == .time_60 ? .appGreenColor : .textFieldColor,foregroundColor:viewModel.selectedMatchTime == .time_60 ? .white : .textColor,cornerRadius: 20 ,callBack: {
                                viewModel.selectedMatchTime = .time_60
                            })
                            
                        }
                        HStack{
                            
                            ListButton2(title: "90 Minutes",
                                        bgColor:viewModel.selectedMatchTime == .time_90 ? .appGreenColor : .textFieldColor,foregroundColor:viewModel.selectedMatchTime == .time_90 ? .white : .textColor,cornerRadius: 20 ,callBack: {
                                viewModel.selectedMatchTime = .time_90
                            })
                            ListButton2(title: "Add Own Time",
                                        bgColor:viewModel.selectedMatchTime == .customTime ? .appGreenColor : .textFieldColor,foregroundColor:viewModel.selectedMatchTime == .customTime ? .white : .textColor,cornerRadius: 20 ,callBack: {
                                viewModel.selectedMatchTime = .customTime
                                viewModel.showCustomTimePopUp = true
                            })
                            
                            
                        }.padding(.top,5)
                        
                        HStack(spacing: 2){
                            Text("Additional Options").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,25)
                        HStack {
                            Text("Extra Time").foregroundColor(Color.textColor).font(Font.mulishMedium(size: 16))
                            Spacer()
                            
                            Image(viewModel.btnExtraTime ? "ons" : "offs").onTapGesture {
                                viewModel.btnExtraTime.toggle()
                            }
                            
                        }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10)
                        HStack {
                            Text("Penalty Shootouts").foregroundColor(Color.textColor).font(Font.mulishMedium(size: 16))
                            Spacer()
                            
                            Image(viewModel.penalty_shootout ? "ons" : "offs").onTapGesture {
                                viewModel.penalty_shootout.toggle()
                            }
                            
                        }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10)
                    }
                    
                    
                    
                }.padding(.horizontal)
                Spacer()
                AppButton(title: "Next", callBack: {
                     viewModel.btnStartMatch()
                    //viewModel.testClick()
                }).padding(.top,50).padding(.horizontal)
            }
            if viewModel.showCustomTimePopUp{
                CustomTimePOPUP(text: $viewModel.txtcustomTime,
                                showCustomTimePopUp: $viewModel.showCustomTimePopUp)
            }
        }.onAppear{
          //viewModel.test()
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert)
    }
}

#Preview {
    StartAMatchFootBallView(viewModel: StartAMatchFootBallViewModel())
}

struct CustomTimePOPUP: View {
    @Binding var text:String
    @Binding var showCustomTimePopUp:Bool
    var callBack:(()->Void)?
    var body: some View {
        ZStack{
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all).onTapGesture {
                showCustomTimePopUp.toggle()
            }
            VStack{
                Text("Add Time in Minutes").font(Font.mulishMedium(size: 32)).foregroundColor(Color.textColor).padding(.top,20)
                HStack(spacing: 15){
                    TextField("", text: $text)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                }.frame(width: 190,height: 38).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.textColorGray, lineWidth: 1)).padding(.top,35)
                Spacer()
                HStack(spacing: 20){
                    
                    Text("Cancel")
                        .frame(maxWidth: 150)
                        .frame(height: 45)
                        .foregroundColor(Color.appGreenColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.appGreenColor, lineWidth: 1))
                        .font(.mulishSemiBold(size: 20.0))
                        .onTapGesture {
                            showCustomTimePopUp = false
                            text = ""
                        }
                    ZStack {
                        Text("OK")
                            .frame(maxWidth: 150)
                            .frame(height: 45)
                            .foregroundColor(Color.white)
                            .background(Color.appGreen)
                            .cornerRadius(10)
                            .font(.mulishSemiBold(size: 20.0))
                            .onTapGesture {
                                showCustomTimePopUp = false
                                callBack?()
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.3), lineWidth: 3) // Adjust opacity as needed
                            .shadow(color: .white, radius: 10, x: 0, y: 0)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(1) // Adjust padding to control the size of the shadow
                    } .frame(maxWidth: 150).frame(height: 40)
                  
                }.padding(.bottom,20)
               
            }.frame(maxWidth: .infinity).frame(height: 272).background(Color.white).cornerRadius(15).shadow(color: .black.opacity(0.25), radius: 15, x: 0, y: 0).padding(.vertical,60).padding(.horizontal)
        }
    }
}
