//
//  StartMatchTennisScoreCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 19/08/2024.
//

import SwiftUI

struct StartMatchTennisScoreCardView: View {
    @ObservedObject var viewModel: StartMatchTennisScoreCardViewModel
    var body: some View {
        
        ZStack{
            VStack{
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator,title: "Start a Match",showUndoButton: true, btnShareCallBack:  {
                    
                }).padding(.top,5)
                ScrollView(showsIndicators: false){
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
                            Text("Select Match Format").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }.padding(.top,25)
                 
                        CustomDropDown(title: viewModel.matchFormat ?? "Match Format",
                                       isShow: $viewModel.isShowmatchFormat,
                                       list: viewModel.matchFormatList,
                                       callBack: {name,index in
                            
                            viewModel.matchFormatList = viewModel.matchFormatList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.matchFormatList[index].isSelected = true
                            viewModel.matchFormat = name
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.isShowmatchFormat.toggle()
                            }
                        })
                        
                        
                        HStack(spacing: 2){
                            Text("Server/ Receiver Preference").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                                //.frame(maxWidth: .infinity,alignment: .leading)
                        }.padding(.top,25)
                 
                        CustomDropDown(title: viewModel.serverReceiver ?? "Server/ Receiver",
                                       isShow: $viewModel.isShowServerReceiver,
                                       list: viewModel.serverReceiverList,
                                       callBack: {name,index in
                            
                            viewModel.serverReceiverList = viewModel.serverReceiverList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.serverReceiverList[index].isSelected = true
                            viewModel.serverReceiver = name
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.isShowServerReceiver.toggle()
                            }
                        })
                        
                        
                        
                        HStack(spacing: 2){
                            Text("Select Match Type").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }.padding(.top,25)
                 
                        CustomDropDown(title: viewModel.matchType ?? "Match Type ",
                                       isShow: $viewModel.isShowMatchType,
                                       list: viewModel.matchTypeList,
                                       callBack: {name,index in
                            
                            viewModel.matchTypeList = viewModel.matchTypeList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.matchTypeList[index].isSelected = true
                            viewModel.matchType = name
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.isShowMatchType.toggle()
                            }
                        })
                     
                        
                        HStack(spacing: 2){
                            Text("Court Number").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                            Text("").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }.padding(.top,25)
                 
                        CustomDropDown(title: viewModel.courtNumber ?? "Court Number",
                                       isShow: $viewModel.isShowCourtNumber,
                                       list: viewModel.courtNumberList,
                                       callBack: {name,index in
                            
                            viewModel.courtNumberList = viewModel.courtNumberList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.courtNumberList[index].isSelected = true
                            viewModel.courtNumber = name
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.isShowCourtNumber.toggle()
                            }
                        })
                        
                        
                        
                       
                        HStack(spacing: 2){
                            Text("Additional Options").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                            Text("").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }.padding(.top,25)
                        
                        HStack {
                            Text("Tiebreaker").foregroundColor(Color.textColor).font(Font.mulishMedium(size: 16))
                            Spacer()
                            
                            Image(viewModel.isShowHandicap ? "ons" : "offs").onTapGesture {
                                viewModel.isShowHandicap.toggle()
                            }
                            
                        }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10)
                    }
                    
                    AppButton(title: "Next", callBack: {
                        viewModel.btnClick()
                        
                    }).padding(.top,50)
                    
                    
                }.padding(.horizontal)
            }.onAppear{
               // viewModel.test()
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert)
    }
}

#Preview {
    StartMatchTennisScoreCardView(viewModel: StartMatchTennisScoreCardViewModel())
}
