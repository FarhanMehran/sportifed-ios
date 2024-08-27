//
//  CreateGameView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI
enum CreateGameDrowDownType{
    case sport
    case playersLimit
    case BYOE
    case skillRequired
}
struct CreateGameView: View {
    
    @ObservedObject var viewModel: CreateGameViewModel
    @State var text = StringConstants.description
    
    var body: some View {
        ZStack{
            
           
                VStack{
                    HomeSecondaryAppBBar(title: viewModel.routType == .createGame ? StringConstants.createGame : "Edit Game", btnBackCallBack: {
                        viewModel.coordinator?.popNavigationView()
                    }, btnShareCallBack:  {
                        
                    }).padding(.top,5)
                    ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        
                        Text(StringConstants.title).font(Font.mulishMedium(size: 18)).padding(.top,20).foregroundColor(Color.textColor)
                        AuthTextField(title: StringConstants.exCricketMatch,type: .normalField ,text: $viewModel.title)
                        
                        Text(StringConstants.description).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,5)
                        
                        HStack {
                            AutoResizableTextView(text: $viewModel.description)
                            
                            
                        }.padding().frame(height: 175).background(Color.textFieldColor).cornerRadius(10)
                        
                        Text(StringConstants.sport).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,5)
                        AppButton(title: viewModel.sport?.name ?? "",buttonType: .dropDown) {
                            viewModel.drowDownType = .sport
                            viewModel.showDropDown.toggle()
                        }
                        
                        
                        Text(StringConstants.venue).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,5)
                        AppButton(title: viewModel.venue,buttonType: .dropDown) {
                            
                        }
                        
                        HStack(spacing: 30){
                            DateButton(title: StringConstants.Date, time: viewModel.gameDate.dateFormat).onTapGesture {
                                viewModel.showDatePicker.toggle()
                            }
                            DateButton(title: StringConstants.time, time: "\(viewModel.gameTime)".timeFormat, image: .ic_clock).onTapGesture {
                                viewModel.showTimePicker.toggle()
                            }
                        }.padding(.top,5)
                        
                        Text(StringConstants.gameAccess).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,5)
                        
                        GameAccessButton(gameAccess: $viewModel.gameAccess).padding(.top,3)
                        
                    }.padding(.horizontal)
                    
                    Text(StringConstants.thisGameCanbeDiscovered).font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray).multilineTextAlignment(.center)
                        .padding(.top,3).padding(.horizontal,40)
                    
                    VStack(alignment: .leading){
                        Text(StringConstants.gameType).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                        VStack (spacing: 20){
                            HStack{
                                Text(StringConstants.regular).font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                                Spacer()
                                
                                CircleBuuton(toggle: $viewModel.regularTogle)
                            }
                            HStack{
                                Text(StringConstants.tournament).font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                                Spacer()
                                
                                CircleBuuton(toggle: $viewModel.isTournamentMatach)
                            }
                        }.padding().frame(height: 100).background(Color.textFieldColor).cornerRadius(10)
                        
                        Text(StringConstants.skillRequired).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,3)
                        
                        AppButton(title: viewModel.skillRequired,buttonType: .dropDown) {
                            viewModel.drowDownType = .skillRequired
                            viewModel.showDropDown.toggle()
                        }
                        
                        HStack(spacing: 30){
                            VStack(alignment: .leading){
                                Text("Team 1 Name").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                                AuthTextField(title: "Team 1 Name", text: $viewModel.team1Name)
                            }
                            VStack(alignment: .leading){
                                Text("Team 2 Name").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                                AuthTextField(title: "Team 2 Name", text: $viewModel.team2Name)
                            }
                        }
                        
                        Text(StringConstants.playersLimit).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,3)
                        AppButton(title: viewModel.playersLimit,buttonType: .dropDown) {
                            viewModel.drowDownType = .playersLimit
                            viewModel.showDropDown.toggle()
                        }
                        
                        Text(StringConstants.BYOE).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,3)
                        AppButton(title: viewModel.byoe ? "Yes" : "No",buttonType: .dropDown) {
                            viewModel.drowDownType = .BYOE
                            viewModel.showDropDown.toggle()
                        }
                        
                        Text(StringConstants.fee).font(Font.mulishMedium(size: 18)).padding(.top,20).foregroundColor(Color.textColor)
                        AuthTextField(title: "AED",type: .normalField ,text: $viewModel.fee)
                        
                        AppButton(title:  viewModel.routType == .createGame ? StringConstants.create : StringConstants.saveChanges, callBack: {
                            viewModel.btnCreateGame()
                        }).padding(.top,30)
                        
                    }.padding(.horizontal)
                    
                }
            }
            
            if viewModel.showTournamentList {
                if let list = viewModel.tournamentList{
                    TournamentListView(list: list,callBack: { item in
                        viewModel.tournament = item.id
                        viewModel.showTournamentList.toggle()
                    },crossCallBack: {
                        viewModel.showTournamentList.toggle()
                    })
                }
            }
            
            if viewModel.showTimePicker {
                TimePickerView(selectedTime: $viewModel.gameTime, cancelCallback: {
                    viewModel.showTimePicker.toggle()
                }, doneCallBack: {
                    viewModel.showTimePicker.toggle()
                })
            }
            
            if viewModel.showDatePicker {
                TimePickerView(selectedTime: $viewModel.gameDate, pickerType: .date, cancelCallback: {
                    viewModel.showDatePicker.toggle()
                }, doneCallBack: {
                    viewModel.showDatePicker.toggle()
                })
            }
            
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
            
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType)
            .popover(isPresented: $viewModel.showDropDown) {
                ScrollView{
                    VStack(spacing: 20){
                        switch viewModel.drowDownType{
                            
                        case .sport :
                            DropDownTitle(text: "Select Sport")
                            
                            if let list = viewModel.favoriteSportsList{
                                ForEach(list, id: \.self) { item in
                                    DropDownText(text: item.name ?? "", callBack: {
                                        viewModel.sport = item
                                        viewModel.showDropDown.toggle()
                                    })
                                }
                            }
                        case .playersLimit :
                            DropDownTitle(text: "Select Players Limit")
                            
                            ForEach(1..<21, id: \.self) { index in
                                DropDownText(text: "\(index)", callBack: {
                                    viewModel.playersLimit = "\(index)"
                                    viewModel.showDropDown.toggle()
                                })
                            }
                            
                        case .BYOE :
                                DropDownTitle(text: "Select BYOE")
                            BYOE(byoe: $viewModel.byoe, callBack: {
                                viewModel.showDropDown.toggle()
                            })
                             
                        case .skillRequired:
                            DropDownTitle(text: "Select SkillRequired")
                            SkillRequiredView(skillRequired: $viewModel.skillRequired, callBack: {
                            viewModel.showDropDown.toggle()
                        })
                        }
                    }.padding(.horizontal).padding(.top)
                }
              
            }.onAppear{
                viewModel.getSports()
                viewModel.getAllTournaments()
                viewModel.changeGameViewAppere()
            }
    }
}

#Preview {
    CreateGameView(viewModel: CreateGameViewModel())
}

struct SkillRequiredView: View {
    
    @Binding var skillRequired:String
    var callBack:(()->Void)
    var body: some View {
        VStack{
            DropDownText(text: "Intermediate", callBack: {
                skillRequired = "Intermediate"
                callBack()
            })
            DropDownText(text: "Beginner", callBack: {
                skillRequired = "Beginner"
                callBack()
            })
        }
    }
}

struct BYOE: View {
    
    @Binding var byoe:Bool
    var callBack:(()->Void)
    var body: some View {
        VStack{
            DropDownText(text: "Yes", callBack: {
                byoe = true
                callBack()
            })
            DropDownText(text: "No", callBack: {
                byoe = false
                callBack()
            })
        }
    }
}

struct CircleBuuton: View {
    
    @Binding var toggle:Bool
    
    var body: some View {
        Button(action: {
            toggle.toggle()
        }, label: {
            Color(toggle ? .appGreen : .clear).frame(width: 14,height: 14).overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.gray, lineWidth:toggle ? 0 : 1)).cornerRadius(40)
        })
    }
}
