//
//  AccountView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var viewModel: AccountViewModel
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                HStack{
                    ZStack{
                        
                        Image.ic_Plus.resizable().frame(width: 20,height: 20)
                    }.frame(width: 60,height: 50).background(Color.textFieldColor).clipShape(Circle()).shadow(color: .white, radius: 0.5, x: 0, y: 0)
                    VStack(alignment: .leading){
                        Text(UserDefaultsManager.shared.userProfileData?.fullName ?? "").font(Font.mulishMedium(size: 18)).foregroundColor(Color.accountTextColor).padding(.top,10)
                        
                        Text(UserDefaultsManager.shared.userProfileData?.email ?? "").font(Font.mulishRegular(size: 12)).foregroundColor(.gray)
                    }
                }.padding(.horizontal)
                CustomDivider().padding(.top,5)
                VStack(alignment: .leading){
                    Text(StringConstants.account).font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor).padding(.top,10)
                    
                    VStack(alignment: .leading,spacing: 10){
                        AccountButton(image: .account_Fill,title: StringConstants.profileSettings,callBack: {
                            viewModel.coordinator?.loadProfileView()
                        }).padding(.top,8)
                        CustomDivider()
                        AccountButton(image: .ic_MyGame,title: StringConstants.myGames,callBack: {
                            viewModel.coordinator?.loadMatchesScoreView(routType: .myGame)
                        })
                        CustomDivider()
                        AccountButton(image: .ic_Pre,title: StringConstants.preferences,callBack: {
                            viewModel.coordinator?.loadPreferencesView()
                            
                        })
                        CustomDivider()
                        AccountButton(image: .ic_MatchesSrore,title: StringConstants.matchesScore,callBack: {
                            viewModel.coordinator?.loadMatchesScoreView(routType: .matchesScore)
                        })
                        CustomDivider()
                        AccountButton(image: .ic_BellGreen,title: StringConstants.notifications,showSwitchButton: true).padding(.bottom,8)
                        
                    }.frame(maxWidth: .infinity).background(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appGrayColor, lineWidth: 0.5)
                    )
                    
                    Text("Help Center").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,10)
                    
                    VStack(alignment: .leading,spacing: 10){
                        AccountButton(image: .ic_Chat,title: StringConstants.chatwithUs,callBack: {
                          //viewModel.coordinator?.loadChatView(item: <#GetlCommunityResponce#>)
                        }).padding(.top,8)
                        CustomDivider()
                        AccountButton(image: .ic_Term,title: StringConstants.termsPolice)
                        CustomDivider()
                       
                        AccountButton(image: .ic_LogOut,title: StringConstants.logOut,callBack: {
                            UserDefaultsManager.shared.authToken = nil
                            viewModel.coordinator?.loadLoginView()
                        }).padding(.bottom,8)
                        
                    }.frame(maxWidth: .infinity).background(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appGrayColor, lineWidth: 0.5)
                    )
                }.padding(.horizontal)
               
            }
        }
    }
}

#Preview {
    AccountView(viewModel: AccountViewModel())
}
