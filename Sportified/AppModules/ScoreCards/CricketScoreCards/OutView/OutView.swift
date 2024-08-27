//
//  OutView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/07/2024.
//

import SwiftUI

struct OutView: View {
    @ObservedObject var viewModel: OutViewModel
    var list = ["WD","NB","BYE","LB"]
    var body: some View {
        ZStack{
            VStack{
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator,title: "Out",showUndoButton: true,btnBackCallBack: {
                    // self.btnOut = false
                }, btnShareCallBack:  {
                    
                }).padding(.top,5)
                VStack{
                    ScrollView{
                        VStack{
                            VStack(alignment: .leading){
                                Text("Who?").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,20)
                                HStack(spacing: 50){
                                    VStack(spacing: 0){
                                        HStack{
                                           
                                            WebImageView(image: viewModel.striker?.img ?? "", placeholder: Image("fi_9957818"))
                                                .frame(width: 140,height: 108)
                                        }.frame(width: 140,height: 110)
                                            .background(viewModel.outPlayerID == 0 ? Color.appGreenColor : Color.appGray).cornerRadius(10, corners: [.topLeft,.topRight])
                                        Spacer()
                                        Text("Striker") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0)).padding(.bottom)
                                    }.frame(width: 140,height: 150).overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.appGray, lineWidth: 1)).onTapGesture {
                                                viewModel.outPlayerID = 0
                                                viewModel.checkOutType()
                                            }
                                    
                                    VStack(spacing: 0){
                                        HStack{
                                          
                                            WebImageView(image: viewModel.nonStriker?.img ?? "", placeholder: Image("Group 1"))
                                                .frame(width: 140,height: 108)
                                            
                                        }.frame(width: 140,height: 110)  .background(viewModel.outPlayerID == 1 ? Color.appGreenColor : Color.appGray).cornerRadius(10, corners: [.topLeft,.topRight])
                                        Spacer()
                                        Text("Non-Striker") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0)).padding(.bottom)
                                    }.frame(width: 140,height: 150).overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.appGray, lineWidth: 1)).onTapGesture {
                                                viewModel.outPlayerID = 1
                                                viewModel.checkOutType()
                                            }
                                    
                                    
                                }.padding(.top)
                                Text("Select Fielder").font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColor).padding(.top,20)
                                HStack(spacing: 50){
                                    VStack(spacing: 0){
                                        HStack{
                                          
                                            WebImageView(image: viewModel.filder?.img ?? "", placeholder: Image("Group 2"))
                                                .frame(width: 140,height: 108)
                                        }.frame(width: 140,height: 110).background(viewModel.filder?.id != nil ? Color.appGreenColor : Color.appGray).cornerRadius(10, corners: [.topLeft,.topRight])
                                        Spacer()
                                        Text("Fielder 1") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0)).padding(.bottom)
                                    }.frame(width: 140,height: 150).overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.appGray, lineWidth: 1)).onTapGesture {
                                                viewModel.showBowlingPlayerList = true
                                            }
                                    
                                    
                                    
                                    
                                }.padding(.top)
                                Text("Delivery Type").font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColor).padding(.top,20)
                            }
                            
                            HStack(spacing: 10){
                                ForEach(0..<4){index in
                                    Text(list[index]).frame(width: 60,height: 40).font(Font.mulishMedium(size: 15))
                                        .foregroundColor(viewModel.extraBalltype == list[index] ? Color.white : Color.textColorGray)
                                        .background(viewModel.extraBalltype == list[index] ? Color.appGreenColor : Color.textFieldColor).cornerRadius(15)
                                        .onTapGesture {
                                            viewModel.extraBalltype = list[index]
                                        }
                                }
                              
                                
                            }.padding(.top,10)
                            HStack{
                                Text("Delivery Type").font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColor).padding(.top,15)
                                Spacer()
                                
                            }.padding(.horizontal,30)
                            HStack(spacing: 15){
                                TextField("", text: $viewModel.runs).padding(.horizontal)
                                    .keyboardType(.numberPad).multilineTextAlignment(.center)
                            }.frame(width: 214,height: 40).overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.textColorGray, lineWidth: 1)).padding(.top,20)
                            
                        }
                        
                    }
                    
                    
                    Spacer()
                    AppButton(title: "Out", callBack: {
                      //  viewModel.test()
                        viewModel.btnClick()
                    }).padding(.top).padding(.horizontal)
                }
            }
            if viewModel.showBowlingPlayerList{
                PlayerListView(userList: viewModel.playerList,
                               temUserList: viewModel.playerList,
                               callBack: {user,index in
                    viewModel.playerList[index].isSelected!.toggle()
                    viewModel.filder = user
                    self.viewModel.showBowlingPlayerList = false
                    
                },btnBackcallBack:{
                    self.viewModel.showBowlingPlayerList = false
                })
            }
            
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
        }.onAppear{
            viewModel.viewWillAppear()
        }
    }
}
#Preview {
    OutView(viewModel: OutViewModel())
}
