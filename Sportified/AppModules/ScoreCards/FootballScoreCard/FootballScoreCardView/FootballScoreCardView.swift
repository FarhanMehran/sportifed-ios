//
//  FootballScoreCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 24/07/2024.
//

import SwiftUI

struct FootballScoreCardView: View {
   @State var list = ["First Half","Second Half","Extra Time","Penalty Shootouts"]
    @ObservedObject var viewModel: FootballScoreCardViewModel
    var body: some View {
        ZStack{
           
                VStack(spacing:0){
                    
                    HomeSecondaryAppBBar(coordinator: viewModel.coordinator,
                                         title: "Football Score Card",
                                         showUndoButton: true,
                                         btnShareCallBack:  {
                        
                    }).padding(.top,5)
                    TimerView(time: viewModel.otpTimePatternLogin,isCheck: viewModel.isStopTime,callBack: {
                        viewModel.isStopTime.toggle()
                    })
                    ScrollView(showsIndicators: false){
                    HStack{
                        ForEach(0..<4, id: \.self) { item in
                            VStack {
                                Text(list[item])
                                    .font(Font.mulishMedium(size: 12))
                                    .foregroundColor(viewModel.selectedTime == item ? Color.appGreenColor : Color.gray)
                            }
                            .frame(width: 80, height: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.selectedTime == item ? Color.appGreenColor : Color.gray, lineWidth: 1)
                                
                            ).onTapGesture {
                                if viewModel.selectedTime == 3{
                                    viewModel.showFoulDropDown.toggle()
                                }
                                viewModel.selectedTime = item
                            }
                        }
                    }.padding(.top)
                    VStack(spacing: 10){
                        HStack{
                            Text("Add Goal").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(.top)
                            Spacer()
                        }
                        
                        CustomDropDown(title: viewModel.goalSelectTeam.name ?? "Select Team",
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
                                viewModel.goalSelectTeam = viewModel.nearbyMatchesitem?.teams?.first ?? Team()
                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.first?.id ?? 0
                            }else{
                                viewModel.goalSelectTeam = viewModel.nearbyMatchesitem?.teams?.last ?? Team()
                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.last?.id ?? 0
                                
                            }
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.showSelectedTeam.toggle()
                            }
                            viewModel.card_type = nil
                            viewModel.foulSelectTeam = Team()
                            //viewModel.yellowSelectTeam = Team()
                            //viewModel.redSelectTeam = Team()
                        })
                    
                        AppButton(title: viewModel.goleSelectPlayer.fullName ?? "Select Player",height: 50,buttonType: .dropDown, callBack: {
                            viewModel.showDropdown.toggle()
                            viewModel.dropDownType = .goleSelectPlayer
                            viewModel.card_type = nil
                        })
                        
                        CustomDropDown(title: viewModel.goalType ?? "Goal Type",
                                       isShow: $viewModel.showGoleType,
                                       list: viewModel.goalTypeList,
                                       callBack: {name,index in
                            
                            viewModel.goalTypeList = viewModel.goalTypeList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.goalTypeList[index].isSelected = true
                            if index == 0{
                                viewModel.goalType = "normal"
                            }else if index == 1{
                                viewModel.goalType = "extra_time"
                            }else{
                                viewModel.goalType = "penalty"
                            }
                          
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.showGoleType.toggle()
                            }
                            viewModel.card_type = nil
                            viewModel.foulSelectTeam = Team()
                           // viewModel.yellowSelectTeam = Team()
                            //viewModel.redSelectTeam = Team()
                        })

                        HStack(spacing: 20){
                            Button {
                                viewModel.goalSelectTeam = Team()
                                viewModel.goalType = nil
                                viewModel.playerList = []
                                viewModel.goleSelectPlayer = User()
                                viewModel.goalTypeList = viewModel.goalTypeList.map { user in
                                    var updatedUser = user
                                    updatedUser.isSelected = false
                                    return updatedUser
                                }
                                viewModel.teamList = viewModel.teamList.map { user in
                                    var updatedUser = user
                                    updatedUser.isSelected = false
                                    return updatedUser
                                }
                            
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
                                viewModel.btnGole()
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
//                        HStack{
//                            Text("Add Foul").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(.top)
//                            Spacer()
//                        }
//                        
//                        CustomDropDown(title: viewModel.foulSelectTeam.name ?? "Select Team",
//                                       isShow: $viewModel.showFoulSelectedTeam,
//                                       list: viewModel.teamList,
//                                       callBack: {name,index in
//                            viewModel.teamList = viewModel.teamList.map { user in
//                                var updatedUser = user
//                                updatedUser.isSelected = false
//                                return updatedUser
//                            }
//                            viewModel.teamList[index].isSelected = true
//                            if index == 0{
//                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.first?.id ?? 0
//                                viewModel.foulSelectTeam = viewModel.nearbyMatchesitem?.teams?.first ?? Team()
//
//                            }else{
//                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.last?.id ?? 0
//                                viewModel.foulSelectTeam = viewModel.nearbyMatchesitem?.teams?.last ?? Team()
//                            }
//                            withAnimation(.easeInOut(duration: 0.3)) {
//                                viewModel.showFoulSelectedTeam.toggle()
//                            }
//                            viewModel.card_type = nil
//                            viewModel.goalSelectTeam = Team()
//                            viewModel.yellowSelectTeam = Team()
//                            viewModel.redSelectTeam = Team()
//                        })
//                        
//                        AppButton(title: viewModel.foulSelectPlayer.fullName ?? "Select Player",height: 50,buttonType: .dropDown, callBack: {
//                            viewModel.showDropdown.toggle()
//                            viewModel.dropDownType = .foulSelectPlayer
//                            viewModel.card_type = nil
//                        })
//                        AppButton(title: viewModel.otpTimePatternLogin,height: 50,buttonType: .dropDown, callBack: {})
//                        HStack{
//                            Text("Add Yellow Card").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(.top)
//                            Spacer()
//                        }
//                        
//                        CustomDropDown(title: viewModel.yellowSelectTeam.name ?? "Select Team",
//                                       isShow: $viewModel.showYellowSelectedTeam,
//                                       list: viewModel.teamList,
//                                       callBack: {name,index in
//                           
//                            viewModel.teamList = viewModel.teamList.map { user in
//                                var updatedUser = user
//                                updatedUser.isSelected = false
//                                return updatedUser
//                            }
//                            viewModel.teamList[index].isSelected = true
//                            if index == 0{
//                                viewModel.yellowSelectTeam = viewModel.nearbyMatchesitem?.teams?.first ?? Team()
//                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.first?.id ?? 0
//                            }else{
//                                viewModel.yellowSelectTeam = viewModel.nearbyMatchesitem?.teams?.last ?? Team()
//                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.last?.id ?? 0
//                            }
//                            withAnimation(.easeInOut(duration: 0.3)) {
//                                viewModel.showYellowSelectedTeam.toggle()
//                            }
//                            viewModel.card_type = "yellow_card"
//                            viewModel.goalSelectTeam = Team()
//                            viewModel.foulSelectTeam = Team()
//                            viewModel.redSelectTeam = Team()
//                        })
//                        
//                        
//                        AppButton(title: viewModel.yellowSelectPlayer.fullName ?? "Select Player",height: 50,buttonType: .dropDown, callBack: {
//                            viewModel.showDropdown.toggle()
//                            viewModel.dropDownType = .yellowSelectPlayer
//                        })
//                        HStack{
//                            Text("Add Red Card").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(.top)
//                            Spacer()
//                        }
//                        CustomDropDown(title: viewModel.redSelectTeam.name ?? "Select Team",
//                                       isShow: $viewModel.showRexSelectedTeam,
//                                       list: viewModel.teamList,
//                                       callBack: {name,index in
//                           
//                            viewModel.teamList = viewModel.teamList.map { user in
//                                var updatedUser = user
//                                updatedUser.isSelected = false
//                                return updatedUser
//                            }
//                            viewModel.teamList[index].isSelected = true
//                            if index == 0{
//                                viewModel.redSelectTeam = viewModel.nearbyMatchesitem?.teams?.first ?? Team()
//                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.first?.id ?? 0
//
//                            }else{
//                                viewModel.redSelectTeam = viewModel.nearbyMatchesitem?.teams?.last ?? Team()
//                                viewModel.team_id = viewModel.nearbyMatchesitem?.teams?.last?.id ?? 0
//                            }
//                            withAnimation(.easeInOut(duration: 0.3)) {
//                                viewModel.showRexSelectedTeam.toggle()
//                            }
//                            
//                            viewModel.card_type = "red_card"
//                            viewModel.goalSelectTeam = Team()
//                            viewModel.foulSelectTeam = Team()
//                            viewModel.yellowSelectTeam = Team()
//                        })
//                        AppButton(title: viewModel.redelectPlayer.fullName ?? "Select Player",height: 50,buttonType: .dropDown, callBack: {
//                            viewModel.showDropdown.toggle()
//                            viewModel.dropDownType = .redelectPlayer
//                        })
                       
                        Text("*Five minutes of extra time will be added after the second half. If no goals are scored, the game will proceed to penalty shootouts.").font(Font.mulishBold(size: 12)).foregroundColor(Color.textColorGray).padding(.top,40)
                        AppButton(title: "Complete Match", callBack: {
                            print("af")
                            viewModel.btnGole()
                        }).padding(.top)
                    }.padding(.horizontal)
                    
                    
                }
            }.onAppear{
                viewModel.otpResendTimer()
                // viewModel.test()
                viewModel.viewWillAppear()
                
                
            }
            if viewModel.showFoulDropDown{
                FoulSheet(viewModel:viewModel)
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
                    viewModel.goleSelectPlayer = user
                    viewModel.foulSelectPlayer = User()
                   // viewModel.yellowSelectPlayer = User()
                    //viewModel.redelectPlayer = User()
                }else if viewModel.dropDownType == .foulSelectPlayer{
                    viewModel.foulSelectPlayer = user
                    viewModel.goleSelectPlayer = User()
                    //viewModel.yellowSelectPlayer = User()
                  //viewModel.redelectPlayer = User()
                }else if viewModel.dropDownType == .yellowSelectPlayer{
                    //viewModel.yellowSelectPlayer = user
                    viewModel.goleSelectPlayer = User()
                    viewModel.foulSelectPlayer = User()
                   // viewModel.redelectPlayer = User()
                }else if viewModel.dropDownType == .redelectPlayer{
                   // viewModel.redelectPlayer = user
                    viewModel.goleSelectPlayer = User()
                    viewModel.foulSelectPlayer = User()
                   // viewModel.yellowSelectPlayer = User()
                }
                viewModel.showDropdown = false
            }).onAppear{
                viewModel.getTeam()
            }
           
        }
    }
}

#Preview {
    FootballScoreCardView(viewModel: FootballScoreCardViewModel())
}



struct FoulSheet: View {
    @ObservedObject var viewModel: FootballScoreCardViewModel
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
                        Text("Card Type").font(Font.mulishBold(size: 20)).foregroundColor(Color.textColor).padding(.top)
                        Spacer()
                    }
                    
                    HStack(spacing: 20){
                        
                        Text("Red Card")
                            .frame(maxWidth: 150)
                            .frame(height: 41)
                            .foregroundColor(viewModel.card_type == "red_card" ? Color.white : Color.appGreenColor)
                            .background(viewModel.card_type == "red_card" ? Color.appGreenColor : Color.clear).cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appGreenColor, lineWidth: 1))
                        
                            .font(.mulishMedium(size: 15))
                            .onTapGesture {
                                viewModel.card_type = "red_card"
                            }
                    
                        
                        Text("Yellow Card")
                            .frame(maxWidth: 150)
                            .frame(height: 41)
                            .foregroundColor(viewModel.card_type == "yellow_card" ? Color.white : Color.appGreenColor)
                            .background(viewModel.card_type == "yellow_card" ? Color.appGreenColor : Color.clear).cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appGreenColor, lineWidth: 1))
                        
                            .font(.mulishMedium(size: 15))
                            .onTapGesture {
                                viewModel.card_type = "yellow_card"
                            }
                        
                        Text("No Card")
                            .frame(maxWidth: 150)
                            .frame(height: 41)
                            .foregroundColor(viewModel.card_type == "No Card" ? Color.white : Color.appGreenColor)
                            .background(viewModel.card_type == "No Card" ? Color.appGreenColor : Color.clear).cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appGreenColor, lineWidth: 1))
                        
                            .font(.mulishMedium(size: 15))
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
