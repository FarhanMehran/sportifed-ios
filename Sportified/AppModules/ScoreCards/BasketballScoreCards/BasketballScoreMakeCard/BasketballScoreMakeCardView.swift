//
//  BasketballScoreMakeCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 15/08/2024.
//

import SwiftUI

struct BasketballScoreMakeCardView: View {
    @State var list = ["First Quarter","Second Quarter","Third Quarter","Forth Quarter","Extra Time"]
    @ObservedObject var viewModel: BasketballScoreMakeCardViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ZStack{
            
            VStack(spacing:0){
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator,
                                     title: "Match Management",
                                     showUndoButton: true,
                                     btnShareCallBack:  {
                    
                }).padding(.top,5)
                TimerView(time: viewModel.otpTimePatternLogin,isCheck: viewModel.isStopTime,callBack: {
                    viewModel.isStopTime.toggle()
                })
                ScrollView(showsIndicators: false){
                    HStack{
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(0..<5, id: \.self) { item in
                                VStack {
                                    Text(list[item])
                                        .font(Font.mulishMedium(size: 12))
                                        .foregroundColor(viewModel.selectedTime == item ? Color.appGreenColor : Color.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(viewModel.selectedTime == item ? Color.appGreenColor : Color.gray, lineWidth: 1)
                                )
                                .onTapGesture {
                                    viewModel.selectedTime = item
                                }
                            }
                        }
                    }.padding(.top).padding(.horizontal)
                    VStack(spacing: 10){
                        HStack{
                            Text("Add Points").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(.top)
                            Spacer()
                        }
                        
                        CustomDropDown(title: viewModel.addPointsSelectTeam.name ?? "Select Team",
                                       isShow: $viewModel.showSelectedTeam,
                                       list: viewModel.teamList,
                                       callBack: {name,index in
                            
                            viewModel.teamList = viewModel.teamList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.teamList[index].isSelected = true
                            if index == 0{
                                viewModel.addPointsSelectTeam = viewModel.nearbyMatchesitem?.teams?.first ?? Team()
                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.first?.id ?? 0
                            }else{
                                viewModel.addPointsSelectTeam = viewModel.nearbyMatchesitem?.teams?.last ?? Team()
                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.last?.id ?? 0
                                
                            }
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.showSelectedTeam.toggle()
                            }
                            
                            viewModel.addTimeoutSelectTeam = Team()
                            viewModel.foulSelectTeam = Team()
                            viewModel.addPointsSelectPlayer = User()
                            viewModel.foulSelectPlayer = User()
                            viewModel.addPontTxt = nil
                        })
                        
                        AppButton(title: viewModel.addPointsSelectPlayer.fullName ?? "Select Player",height: 50,buttonType: .dropDown, callBack: {
                            viewModel.showDropdown.toggle()
                            viewModel.dropDownType = .goleSelectPlayer
                           
                        })
                        
                        CustomDropDown(title: viewModel.addPontTxt ?? "Add Points",
                                       isShow: $viewModel.showAddPoint,
                                       list: viewModel.addPoint,
                                       callBack: {name,index in
                            
                            viewModel.addPoint = viewModel.addPoint.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.addPoint[index].isSelected = true
                          
                            
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.showAddPoint.toggle()
                            }
                            viewModel.addPontTxt = name
                        })
                        
                        
                        HStack(spacing: 20){
                            Button {
                             
                            
                            } label: {
                                Text("Cancel")
                                    .frame(maxWidth: 150)
                                    .frame(height: 45)
                                    .foregroundColor(Color.appGreenColor)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.appGreenColor, lineWidth: 1))
                                
                                    .font(.mulishSemiBold(size: 20.0))
                                 
                                  
                            }
                            Button {
                              
                            } label: {
                            ZStack {
                                    Text("Confirm")
                                        .frame(maxWidth: 150)
                                        .frame(height: 45)
                                        .foregroundColor(Color.white)
                                        .background(Color.appGreen)
                                        .cornerRadius(10)
                                        .font(.mulishSemiBold(size: 20.0))
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 3) // Adjust opacity as needed
                                        .shadow(color: .white, radius: 10, x: 0, y: 0)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding(1) // Adjust padding to control the size of the shadow
                                } .frame(maxWidth: 150).frame(height: 40)
                                    
                            }
                        }.padding(.top)
                        

                        
                        HStack{
                            Text("Add Timeout").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(.top)
                            Spacer()
                        }
                        CustomDropDown(title: viewModel.addTimeoutSelect ?? "Timeout Type",
                                       isShow: $viewModel.showAddTimeoutTypeSelectTeam,
                                       list: viewModel.outTimeList,
                                       callBack: {name,index in
                            
                            viewModel.teamList = viewModel.teamList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.teamList[index].isSelected = true
                            viewModel.addTimeoutSelect = name
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.showAddTimeoutTypeSelectTeam.toggle()
                            }
                           
                       
                        })
                        
                        CustomDropDown(title: viewModel.addTimeoutSelectTeam.name ?? "Select Team",
                                       isShow: $viewModel.showAddTimeoutSelectTeam,
                                       list: viewModel.teamList,
                                       callBack: {name,index in
                            
                            viewModel.teamList = viewModel.teamList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.teamList[index].isSelected = true
                            if index == 0{
                                viewModel.addTimeoutSelectTeam = viewModel.nearbyMatchesitem?.teams?.first ?? Team()
                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.first?.id ?? 0
                            }else{
                                viewModel.addTimeoutSelectTeam = viewModel.nearbyMatchesitem?.teams?.last ?? Team()
                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.last?.id ?? 0
                            }
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.showAddTimeoutSelectTeam.toggle()
                            }
                           
                            viewModel.addPointsSelectTeam = Team()
                            viewModel.foulSelectTeam = Team()
                            viewModel.addPointsSelectPlayer = User()
                            viewModel.foulSelectPlayer = User()
                            viewModel.addPontTxt = nil
                            viewModel.addPoint = viewModel.addPoint.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.teamList = viewModel.teamList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                        })
                        
                        
                   
                        
                        AppButton(title: viewModel.otpTimePatternLogin,height: 50,buttonType: .dropDown, callBack: {})
                       
                        HStack(spacing: 20){
                            Button {
                             
                            
                            } label: {
                                Text("Cancel")
                                    .frame(maxWidth: 150)
                                    .frame(height: 45)
                                    .foregroundColor(Color.appGreenColor)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.appGreenColor, lineWidth: 1))
                                
                                    .font(.mulishSemiBold(size: 20.0))
                                 
                                  
                            }
                            Button {
                              
                            } label: {
                            ZStack {
                                    Text("Confirm")
                                        .frame(maxWidth: 150)
                                        .frame(height: 45)
                                        .foregroundColor(Color.white)
                                        .background(Color.appGreen)
                                        .cornerRadius(10)
                                        .font(.mulishSemiBold(size: 20.0))
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 3) // Adjust opacity as needed
                                        .shadow(color: .white, radius: 10, x: 0, y: 0)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding(1) // Adjust padding to control the size of the shadow
                                } .frame(maxWidth: 150).frame(height: 40)
                                    
                            }
                        }.padding(.top)
                        
                        
                         HStack{
                             Button {
                                 viewModel.showFoulDropDown.toggle()
                             } label: {
                                 Text("Fouls") .foregroundColor(Color.textColor)
                                     .font(.mulishSemiBold(size: 18))
                                 Spacer()
                                 ZStack{
                                     Color.appGreenColor.frame(width: 40,height: 40).clipShape(.circle)
                                     Text("+").foregroundColor(Color.white)
                                         .font(.mulishSemiBold(size: 28))
                                         .padding(.bottom,5)
                                 }
                             }.padding(.horizontal).frame(height: 80) .background(Color.white) .overlay(
                                 RoundedRectangle(cornerRadius: 10)
                                     .stroke(Color.textFieldColor, lineWidth: 2)).padding(.top,20).onTapGesture {
                                         
                                     }
                         }
                        Text("*If the game is tied at the end of the fourth quarter, a five-minute overtime period will be played. If the game remains tied after the overtime, additional five-minute overtime periods will be played until a winner is determined.").font(Font.mulishBold(size: 12)).foregroundColor(Color.textColorGray).padding(.top)
                        AppButton(title: "Complete Match", callBack: {
                            
                            viewModel.btnGole()
                        }).padding(.top)
                    }.padding(.horizontal)
                    
                    
                }
            }.onAppear{
                viewModel.otpResendTimer()
                viewModel.test()
                viewModel.viewWillAppear()
                
                
            }
            if viewModel.showFoulDropDown{
                BasketballFoulSheet(viewModel: viewModel)
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType).popover(isPresented: $viewModel.showDropdown) {
            
            
            PlayerListView(hideAppBar: true,userList: viewModel.playerList,
                           temUserList: viewModel.playerList,
                           selectedPlayerID: 0,
                           callBack: {user,index in
                viewModel.playerList = viewModel.playerList.map { user in
                    var updatedUser = user
                    updatedUser.isSelected = false
                    return updatedUser
                }
                viewModel.player_id = user.id
                viewModel.playerList[index].isSelected = true
                if viewModel.dropDownType == .goleSelectPlayer{
                    viewModel.addPointsSelectPlayer = user
                    viewModel.foulSelectPlayer = User()
                   
                   
                }else if viewModel.dropDownType == .foulSelectPlayer{
                    viewModel.foulSelectPlayer = user
                    viewModel.addPointsSelectPlayer = User()
                   
                    
                }else if viewModel.dropDownType == .yellowSelectPlayer{
                   
                    viewModel.addPointsSelectPlayer = User()
                    viewModel.foulSelectPlayer = User()
                    
                }else if viewModel.dropDownType == .redelectPlayer{
                    
                    viewModel.addPointsSelectPlayer = User()
                    viewModel.foulSelectPlayer = User()
                   
                }
                viewModel.showDropdown = false
            }).onAppear{
                viewModel.getTeam()
            }
            
        }
    }
}

#Preview {
    BasketballScoreMakeCardView(viewModel: BasketballScoreMakeCardViewModel())
}
struct BasketballFoulSheet: View {
    @ObservedObject var viewModel: BasketballScoreMakeCardViewModel
    var body: some View {
        ZStack{
            Color.black.opacity(0.2).onTapGesture {
            viewModel.showFoulDropDown.toggle()
            }
            VStack{
                Spacer()
                VStack{
                    Text("Add Foul") .foregroundColor(Color.textColor)
                        .font(.mulishRegular(size: 32)).padding(.top)
                    HStack(spacing: 20){
                        
                        Text(viewModel.getTeamName(team: 0) ?? "")
                            .frame(maxWidth: 150)
                            .frame(height: 41)
                            .foregroundColor(viewModel.isSelectedFoulTeam == 0 ? Color.white : Color.appGreenColor)
                            .background(viewModel.isSelectedFoulTeam == 0 ? Color.appGreenColor : Color.clear).cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appGreenColor, lineWidth: 1))
                           
                            .font(.mulishMedium(size: 15))
                            .onTapGesture {
                                viewModel.isSelectedFoulTeam = 0
                                viewModel.foulSelectTeam = viewModel.nearbyMatchesitem?.teams?.first ?? Team()
                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.first?.id ?? 0
                            }
                    
                        
                        Text(viewModel.getTeamName(team: 1) ?? "")
                            .frame(maxWidth: 150)
                            .frame(height: 41)
                            .background(viewModel.isSelectedFoulTeam == 1 ? Color.appGreenColor : Color.clear).cornerRadius(10)
                            .foregroundColor(viewModel.isSelectedFoulTeam == 1 ? Color.white : Color.appGreenColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appGreenColor, lineWidth: 1))
                        
                            .font(.mulishMedium(size: 15))
                            .onTapGesture {
                                viewModel.isSelectedFoulTeam = 1
                                viewModel.foulSelectTeam = viewModel.nearbyMatchesitem?.teams?.last ?? Team()
                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.last?.id ?? 0
                            }
                    }.padding(.top)
                    
                    HStack{
                        Text("Select Player").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(.top)
                        Spacer()
                    }
                    AppButton(title: viewModel.foulSelectPlayer.fullName ?? "Select Player",height:55, buttonType: .dropDown, callBack: {
                        viewModel.showDropdown.toggle()
                        viewModel.dropDownType = .foulSelectPlayer
                    })

                    
                    HStack{
                        Text("Foul Type").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(.top)
                        Spacer()
                    }
                    
                    HStack(spacing: 20){
                        
                        Text("Personal Foul")
                            .frame(maxWidth: 150)
                            .frame(height: 41)
                            .foregroundColor(viewModel.card_type == "red_card" ? Color.white : Color.appGreenColor)
                            .background(viewModel.card_type == "red_card" ? Color.appGreenColor : Color.clear).cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appGreenColor, lineWidth: 1))
                        
                            .font(.mulishMedium(size: 13))
                            .onTapGesture {
                                viewModel.card_type = "red_card"
                            }
                    
                        
                        Text("Technical Foul")
                            .frame(maxWidth: 150)
                            .frame(height: 41)
                            .foregroundColor(viewModel.card_type == "yellow_card" ? Color.white : Color.appGreenColor)
                            .background(viewModel.card_type == "yellow_card" ? Color.appGreenColor : Color.clear).cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appGreenColor, lineWidth: 1))
                        
                            .font(.mulishMedium(size: 13))
                            .onTapGesture {
                                viewModel.card_type = "yellow_card"
                            }
                        
                        Text("Flagrant Foul")
                            .frame(maxWidth: 150)
                            .frame(height: 41)
                            .foregroundColor(viewModel.card_type == "No Card" ? Color.white : Color.appGreenColor)
                            .background(viewModel.card_type == "No Card" ? Color.appGreenColor : Color.clear).cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appGreenColor, lineWidth: 1))
                        
                            .font(.mulishMedium(size: 13))
                            .onTapGesture {
                                viewModel.card_type = "No Card"
                            }
                    }.padding(.top)
                    HStack(spacing: 20){
                        
                        Text("Cancel")
                            .frame(maxWidth: 150)
                            .frame(height: 41)
                            .foregroundColor(Color.appGreenColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appGreenColor, lineWidth: 1))
                        
                            .font(.mulishMedium(size: 15))
                            .onTapGesture {
                                viewModel.playerList = []
                                viewModel.foulSelectPlayer = User()
                                viewModel.foulSelectTeam =  Team()
                                viewModel.isSelectedFoulTeam = 3
                                viewModel.card_type = nil
                            }
                    
                        ZStack {
                            Text("Confirm")
                                .frame(maxWidth: 150)
                                .frame(height: 45)
                                .foregroundColor(Color.white)
                                .background(Color.appGreen)
                                .cornerRadius(10)
                                .font(.mulishSemiBold(size: 20.0))
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.3), lineWidth: 3) // Adjust opacity as needed
                                .shadow(color: .white, radius: 10, x: 0, y: 0)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(1) // Adjust padding to control the size of the shadow
                        } .frame(maxWidth: 150).frame(height: 40)
                            .onTapGesture {
                                viewModel.btnGole()
                             
                            }
                    }.padding(.top)
                    Spacer()
                }.padding(.horizontal).frame(height: 500).background(Color.white).cornerRadius(20).shadow(color: .black.opacity(0.25), radius: 15, x: 0, y: 0)
            }
        }.ignoresSafeArea(.all)
    }
}
