//
//  StartInningsView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 18/07/2024.
//

import SwiftUI

struct StartInningsView: View {
    @ObservedObject var viewModel: StartInningsViewModel

    var body: some View {
        ZStack{
            VStack{
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator,title: "Start Innings",showUndoButton: true, btnShareCallBack:  {
                    
                }).padding(.top,5)
                VStack{
                    ScrollView{
                        VStack(alignment: .leading){
                            Text("Batting- Team A").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,20)
                            HStack(spacing: 50){
                                VStack(spacing: 0){
                                    HStack{
                                       
                                        WebImageView(image: viewModel.striker?.img ?? "", placeholder: Image("fi_9957818"))
                                            .frame(width: 140,height: 108)
                                    }.frame(width: 140,height: 110).background(Color.appGray).cornerRadius(10, corners: [.topLeft,.topRight])
                                    Spacer()
                                    Text("Select Striker") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0)).padding(.bottom)
                                }.frame(width: 140,height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appGray, lineWidth: 1)).onTapGesture {
                                            viewModel.showBatingPlayerList = 1
                                        }
                                
                                VStack(spacing: 0){
                                    HStack{
                                        
                                        WebImageView(image: viewModel.nonStriker?.img ?? "", placeholder:  Image("Group 1"))
                                            .frame(width: 140,height: 108)
                                    }.frame(width: 140,height: 110).background(Color.appGray).cornerRadius(10, corners: [.topLeft,.topRight])
                                    Spacer()
                                    Text("Select Non-Striker") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0)).padding(.bottom)
                                }.frame(width: 140,height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appGray, lineWidth: 1)).onTapGesture {
                                            viewModel.showBatingPlayerList = 2
                                        }
                                
                                
                            }.padding(.top)
                            Text("Bowling - Team B").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,20)
                            HStack(spacing: 50){
                                VStack(spacing: 0){
                                    HStack{
                                      
                                        WebImageView(image: viewModel.bowler?.img ?? "", placeholder:  Image("Group 2"))
                                            .frame(width: 140,height: 108)
                                    }.frame(width: 140,height: 110).background(Color.appGray).cornerRadius(10, corners: [.topLeft,.topRight])
                                    Spacer()
                                    Text("Select Bowler") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0)).padding(.bottom)
                                }.frame(width: 140,height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appGray, lineWidth: 1)).onTapGesture {
                                            viewModel.showBowlingPlayerList = 1
                                        }
                                
                                VStack(spacing: 0){
                                    HStack{
                                        
                                        WebImageView(image: viewModel.keeper?.img ?? "", placeholder:  Image("Group 3"))
                                            .frame(width: 140,height: 108)
                                    }.frame(width: 140,height: 110).background(Color.appGray).cornerRadius(10, corners: [.topLeft,.topRight])
                                    Spacer()
                                    Text("Select Keeper ") .foregroundColor(.textColor) .font(.mulishRegular(size: 15.0)).padding(.bottom)
                                }.frame(width: 140,height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appGray, lineWidth: 1)).onTapGesture {
                                            viewModel.showBowlingPlayerList = 2
                                        }
                                
                                
                            }.padding(.top)
                            
                            
                        }
                        
                    }
                    Spacer()
                    AppButton(title: "Start Scoring", callBack: {
                       // viewModel.test()
                        viewModel.btnClick()
                        
                    }).padding(.top).padding(.horizontal)
                }
            }
            /// select Striker and nonStriker
            if viewModel.showBatingPlayerList != 0 {
                PlayerListView(userList: viewModel.battingTeamPlayers,
                               temUserList: viewModel.battingTeamPlayers,
                               selectedPlayerID: viewModel.showBatingPlayerList != 1 ? viewModel.striker?.id : viewModel.nonStriker?.id,
                               callBack: {user,index in
                    if viewModel.showBatingPlayerList == 1 {
                        if let strikerIndex = viewModel.battingTeamPlayers.firstIndex(where: { $0.id == viewModel.striker?.id }) {
                            viewModel.battingTeamPlayers[strikerIndex].isSelected = false
                        }
                        viewModel.striker = user
                    } else {
                        if let nonStrikerIndex = viewModel.battingTeamPlayers.firstIndex(where: { $0.id == viewModel.nonStriker?.id }) {
                            viewModel.battingTeamPlayers[nonStrikerIndex].isSelected = false
                        }
                        viewModel.nonStriker = user
                    }
                    viewModel.battingTeamPlayers[index].isSelected = true
                    self.viewModel.showBatingPlayerList = 0
                    
                },btnBackcallBack:{
                    viewModel.showBatingPlayerList = 0
                })
            }
            
           
            
        if viewModel.showBowlingPlayerList != 0{
            PlayerListView(userList: viewModel.bowlingTeamPlayers,
                           temUserList:  viewModel.bowlingTeamPlayers,
                           selectedPlayerID: viewModel.showBowlingPlayerList != 1 ? viewModel.bowler?.id : viewModel.keeper?.id,
                           callBack: {user,index in
                
                if viewModel.showBowlingPlayerList == 1 {
                    if let strikerIndex = viewModel.bowlingTeamPlayers.firstIndex(where: { $0.id == viewModel.bowler?.id }) {
                        viewModel.bowlingTeamPlayers[strikerIndex].isSelected = false
                    }
                    viewModel.bowler = user
                } else {
                    if let nonStrikerIndex = viewModel.bowlingTeamPlayers.firstIndex(where: { $0.id == viewModel.keeper?.id }) {
                        viewModel.bowlingTeamPlayers[nonStrikerIndex].isSelected = false
                    }
                    viewModel.keeper = user
                }
                viewModel.bowlingTeamPlayers[index].isSelected = true
                self.viewModel.showBowlingPlayerList = 0
            },btnBackcallBack:{
                viewModel.showBowlingPlayerList = 0
            })
        }
            // PlayerListView2(selected: .constant(true)).padding(.horizontal)
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType).onAppear{
            if viewModel.routType == .startInning {
                viewModel.getTeamsPlayer()
            }else{
                viewModel.changeInningTeamSwap()
            }
        }
    }
 
}



#Preview {
    StartInningsView(viewModel: StartInningsViewModel())
}




struct PlayerListView: View{
    var title = "Start Innings"
    var hideAppBar = false
    var userList: [User]
    var temUserList: [User]?
    var selectedPlayerID: Int?
    var callBack:((User,Int)->Void)
    var btnBackcallBack:(()->Void)?
    @State var txtSearch = ""
    var body: some View{
        ZStack{
            VStack{
                if !hideAppBar{
                    HomeSecondaryAppBBar(title: title,showUndoButton: true,
                                         btnBackCallBack: {
                        btnBackcallBack?()
                    }, btnShareCallBack: {
                        btnBackcallBack?()
                    }).padding(.top,5)
                }
                VStack{
                    
                    HStack{
                        HStack {
                            Button {
                                
                            } label: {
                                Image.ic_Search.foregroundColor(Color.textColorGray)
                                    .font(Font
                                        .mulishBold(size: 12))
                            }
                            Spacer()
                            TextField("Search", text:
                                        $txtSearch).foregroundColor(Color.textColorGray)
                                .font(Font
                                    .mulishMedium(size: 14))
                        }.padding().frame(height: 50).background(Color.textFieldColor).cornerRadius(15)
//                        Text("add")
//                            .padding()
//                            .padding(.horizontal)
//                            .frame(width: 150,height: 40)
//                            .foregroundColor(.white)
//                            .background(Color.appGreenColor)
//                            .cornerRadius(6)
//                            .font(.mulishMedium(size: 14.0))
                    }.padding(.top,10)
                    
                    ScrollView{
                        let temUserList = txtSearch.isEmpty ? temUserList : temUserList?.filter{ ($0.fullName ?? "").localizedCaseInsensitiveContains(txtSearch) }
                        ForEach(0..<(temUserList?.count ?? 0), id: \.self) { index in
                            let user = temUserList?[index]
                          //  if !(user?.isSelected ?? false) {
                            if selectedPlayerID != user?.id{
                                    HStack{
                                       
                                        WebImageView(image: user?.img ?? "", placeholder: Image.ic_addPlayer).frame(width: 50,height: 50).clipShape(.circle).onTapGesture {
                                            
                                        }
                                        Text(user?.fullName ?? "").font(Font.mulishMedium(size: 18))
                                            .foregroundColor(Color.textColor)
                                            .padding(.horizontal,4)
                                        
                                        Spacer()
                                        
                                        ZStack{
                                            Color(user?.isSelected ?? false ? .appGreen : .clear)
                                                .frame(width: user?.isSelected ?? false ? 15.8 : 14 ,height: user?.isSelected ?? false ? 15.8 : 14).overlay(RoundedRectangle(cornerRadius: 0, style: .continuous).stroke(Color.textColorGray, lineWidth: user?.isSelected ?? false ? 0 : 1.5))
                                            
                                            Image.ic_Tick.resizable().frame(width: 8,height: 7)
                                            
                                        }.padding(.horizontal)
                                        
                                    }.background(Color.textFieldColor)
                                        .cornerRadius(10).onTapGesture{
                                            callBack(user ?? User(),index)
                                        }
                                }
                            }
                        
                    }.padding(.top)
                    
                }.padding(.top).padding(.horizontal)
            }
        }.background(Color.white)
    }

}



