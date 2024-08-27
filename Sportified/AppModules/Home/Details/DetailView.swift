//
//  DetailView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI

enum DetailViewRoutType {
    case home
    case MatchesScore
}
enum GameTypes:String{
    case cricket = "Cricket"
    case soccer = "Soccer"
}

struct DetailView: View {
    
    @ObservedObject var viewModel: DetailViewModel
   
    var body: some View {
        ZStack{
          
                VStack{
                    HomeSecondaryAppBBar(title: StringConstants.details,showShareButton: true,showEditMatchButton: UserDefaultsManager.shared.userProfileData?.role == UserType.organize.rawValue ? true : false, btnBackCallBack: {
                        viewModel.coordinator?.popNavigationView()
                    }, btnEditMatchCallBack:{
                        viewModel.coordinator?.loadCreatGame(routType: .editGame,
                                                             nearbyMatchesitem: viewModel.nearbyMatchesitem,callBackUpdateData: { data in
                            viewModel.nearbyMatchesitem = data
                            viewModel.callBack(data)
                        })
                    }, btnShareCallBack:  {
                        
                    }).padding(.top,5)
                    ScrollView(showsIndicators: false){
                    VStack{
                        if  viewModel.nearbyMatchesitem?.gameAccess == GameAccess.invite{
                            
                            VStack{
                                ListButton(title: StringConstants.thisfeaturisOnlyforOwner,bgColor: Color.textFieldColor,foregroundColor: Color.textColorGray) {
                                    
                                }
                                Text(StringConstants.gameJoinCode).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                                Button {
                                    UIPasteboard.general.string = viewModel.nearbyMatchesitem?.joinCode
                                    viewModel.validationText = "Copied"
                                    viewModel.toastType = .success
                                } label: {
                                    ZStack{
                                        Text(viewModel.nearbyMatchesitem?.joinCode ?? "").font(Font.mulishMedium(size: 18)).foregroundColor(Color.appGreen)
                                        Image.ic_copy.frame(maxWidth: .infinity,alignment: .trailing).padding(.trailing)
                                    }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical,12).background(Color.textFieldColor).cornerRadius(10).dashedBorder()
                                }
                            }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.appGrayColor, lineWidth: 1)).padding(.top)
                            
                        }
                        Text(viewModel.nearbyMatchesitem?.title ?? "").font(Font.mulishMedium(size: 28)).foregroundColor(Color.textColor).padding(.top,10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(viewModel.nearbyMatchesitem?.gameDateTime?.formattedDateTime ?? "").font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray) .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading){
                            
                            Text(StringConstants.description).font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor) .frame(maxWidth: .infinity, alignment: .leading)
                            Text(viewModel.nearbyMatchesitem?.description ?? "").font(Font.mulishRegular(size: 16)).foregroundColor(Color.textColorGray).frame(maxWidth: .infinity, alignment: .leading).padding(.top,1)
                            
                        }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.appGrayColor, lineWidth: 1))
                        
                        VStack(alignment: .leading){
                            Text(StringConstants.venue).font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor) .frame(maxWidth: .infinity, alignment: .leading)
                            HStack{
                                Image.ic_Loc
                                Text(viewModel.nearbyMatchesitem?.venue ?? "").font(Font.mulishRegular(size: 16)).foregroundColor(Color.textColorGray)
                            }
                        }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.appGrayColor, lineWidth: 1)).padding(.top)
                        
                        
                        VStack(alignment: .leading,spacing: 10){
                            Text(StringConstants.otherDetails).font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor) .frame(maxWidth: .infinity, alignment: .leading)
                            HStack{
                                
                                Text(StringConstants.skillRequired).font(Font.mulishRegular(size: 16)).foregroundColor(Color.textColorGray)
                                Spacer()
                                Text(viewModel.nearbyMatchesitem?.skillRequired?.rawValue ?? "" ).font(Font.mulishMedium(size: 16)).foregroundColor(Color.textColor)
                            }
                            HStack{
                                
                                Text(StringConstants.playersLimit).font(Font.mulishRegular(size: 16)).foregroundColor(Color.textColorGray)
                                Spacer()
                                Text("\(viewModel.nearbyMatchesitem?.playersLimit ?? 0)").font(Font.mulishMedium(size: 16)).foregroundColor(Color.textColor)
                            }
                            HStack{
                                
                                Text(StringConstants.bringYourOwnEquipments).font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                                Spacer()
                                Text("\(viewModel.nearbyMatchesitem?.byoe ?? false)").font(Font.mulishMedium(size: 16)).foregroundColor(Color.textColor)
                            }
                        }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.appGrayColor, lineWidth: 1)).padding(.top)
                        
                        if let teamA = viewModel.nearbyMatchesitem?.teams?.first{
                            VStack(alignment: .leading){
                                Text(teamA.name ?? "" ).font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor) .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ForEach(0..<(teamA.users?.count ?? 0), id: \.self){index in
                                    let users = teamA.users?[index]
                                    HStack{
                                       
                                        WebImageView(image: teamA.users?[index].img ?? "").frame(width: 50,height: 50).clipShape(.circle)
                                            .onTapGesture {
                                                viewModel.fullImage = users?.img ?? ""
                                                viewModel.showProfile.toggle()
                                            }
                                        Text(users?.fullName ?? "").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.horizontal,4)
                                        Spacer()
                                        Text(teamA.name ?? "")
                                            .padding()
                                            
                                            .padding(.horizontal)
                                            .frame(height: 28)
                                            .foregroundColor(Color.white)
                                            .background(Color.appGreenColor)
                                            .cornerRadius(6)
                                            .font(.mulishRegular(size: 12.0))
                                    }
                                }
                            }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.appGrayColor, lineWidth: 1)).padding(.top)
                        }
                 
                        if let teamB = viewModel.nearbyMatchesitem?.teams?.last {
                            VStack(alignment: .leading){
                                Text(teamB.name ?? "").font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor) .frame(maxWidth: .infinity, alignment: .leading)
                                ForEach(0..<(teamB.users?.count ?? 0), id: \.self){index in
                                    let users = teamB.users?[index]
                                    HStack{
                                      
                                        WebImageView(image: users?.img ?? "").frame(width: 50,height: 50).clipShape(.circle).onTapGesture {
                                            viewModel.fullImage = users?.img ?? ""
                                            viewModel.showProfile.toggle()
                                        }
                                        Text(users?.fullName ?? "").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.horizontal,4)
                                        Spacer()
                                       
                                        
                                        Text(teamB.name ?? "")
                                            .padding()
                                            
                                            .padding(.horizontal)
                                            .frame(height: 28)
                                            .foregroundColor(Color.white)
                                            .background(Color.appGreenColor)
                                            .cornerRadius(6)
                                            .font(.mulishRegular(size: 12.0))
                                    }
                                }
                            }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.appGrayColor, lineWidth: 1)).padding(.top)
                        }
                        //now check on id but need with name
                        if viewModel.routType != .MatchesScore{
                            if viewModel.routType == .home && UserDefaultsManager.shared.userProfileData?.role == UserType.organize.rawValue {
                                
                                CreateNewGroupButton(title: "Create Score Card" ,callBack: {
                                    if viewModel.nearbyMatchesitem?.sportName == GameTypes.cricket.rawValue{
                                        viewModel.coordinator?.loadStartCircketMatchView(model: viewModel.nearbyMatchesitem!)
                                    } else if viewModel.nearbyMatchesitem?.sportName == GameTypes.soccer.rawValue{
                                        viewModel.coordinator?.loadStartAMatchFootBallView(model: viewModel.nearbyMatchesitem!)
                                    }
                                }).padding(.top)
                                
                            }
                            
                            
                            Text("This game is Public 🌍").font(Font.mulishItalic(size: 20)).foregroundColor(Color.textColorGray).padding(.top)
                            
                            AppButton(title: "join", callBack: {
                                
                                viewModel.showingAlert.toggle()
                                
                            }).padding(.top,30)
                        }
                        if viewModel.routType == .MatchesScore{
                            if viewModel.nearbyMatchesitem?.sportName == GameTypes.cricket.rawValue{
                                Text(StringConstants.scoreCard).font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor) .frame(maxWidth: .infinity, alignment: .leading).padding(.top)
                                
                                CricketScoreCardSecondSubView(model: viewModel.cricketScoreCardSummary).onAppear{
                                    viewModel.getcricketScoreCardSummary()
                                }
                            }
                        }
                    }.padding(.horizontal)
                }
            }
            
            if viewModel.showingAlert{
                ZStack{
                    VStack{
                        ZStack{
                            Text(StringConstants.gameJoinCode).font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor).padding(.top)
                            
                            Button {
                                viewModel.showingAlert.toggle()
                            } label: {
                                HStack{
                                    Spacer()
                                    
                                    ZStack{
                                        Text("X").font(Font.mulishBold(size: 15)).foregroundColor(Color.red)
                                    }.frame(width: 30, height: 30).background(Color.textFieldColor)
                                        .clipShape(.circle)
                                }.padding(.top)
                            }

                        }
                        if  viewModel.nearbyMatchesitem?.gameAccess == GameAccess.invite{
                            Text("Enter the code to join game").font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                            
                            ZStack {
                                HStack(spacing: 15) {
                                    ForEach(0..<viewModel.otpCode.count, id: \.self) { index in
                                        Text(viewModel.getOTPCode(index: index)).font(Font.mulishMedium(size: 24)).frame(width: 79, height: 75)
                                            .background(Color.textFieldColor).foregroundColor(Color.textColor).cornerRadius(15)
                                    }
                                }
                                
                                TextField("", text: $viewModel.joinCode)
                                    .font(Font.mulishMedium(size: 22)).frame(maxHeight: 55).padding(.horizontal, 20).multilineTextAlignment(.center).foregroundColor(.clear).accentColor(.clear).background(Color.clear).keyboardType(.numberPad)
                                
                            }.padding(.top,20)
                        }
                        
                        Text("Select Your Team").font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColor).frame(maxWidth: .infinity,alignment: .leading).padding(.top)
                        VStack (spacing: 15){
                            HStack{
                                Text(viewModel.nearbyMatchesitem?.teams?.first?.name ?? "").font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                                Spacer()
                                
                                CircleBuuton(toggle: $viewModel.teamA)
                            }
                            HStack{
                                Text(viewModel.nearbyMatchesitem?.teams?.last?.name ?? "").font(Font.mulishRegular(size: 15)).foregroundColor(Color.textColorGray)
                                Spacer()
                                
                                CircleBuuton(toggle: $viewModel.teamB)
                            }
                        }.padding().frame(height: 100).background(Color.textFieldColor).cornerRadius(10)
                        
                        AppButton(title: "join", callBack: {
                            viewModel.btnJoinMatch()
                        }).padding(.top,30)
                        Spacer()
                    }.padding(.horizontal).frame(maxWidth: .infinity,maxHeight: 320).background(Color.white).cornerRadius(20)  .shadow(color: .black.opacity(0.25), radius: 15, x: 0, y: 0).padding(.horizontal)
                }.frame(maxWidth: .infinity,maxHeight: .infinity).background(Color.textFieldColor.opacity(0.8)).edgesIgnoringSafeArea(.all)
            }
            
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
            if viewModel.showProfile{
                withAnimation{
                    FullScreenImageView(image:viewModel.fullImage ,isShow: $viewModel.showProfile)
                }
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType)
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel())
}
