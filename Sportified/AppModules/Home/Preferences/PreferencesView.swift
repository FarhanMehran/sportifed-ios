//
//  PreferencesView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct PreferencesView: View {
    
    @ObservedObject var viewModel: PreferencesViewModel
    
    var body: some View {
        ZStack{
            VStack{
                HomeSecondaryAppBBar(title: StringConstants.preferences, btnBackCallBack: {
                    viewModel.coordinator?.popNavigationView()
                }).padding(.top,5)
                
                VStack(alignment: .leading){
                    //                Text(StringConstants.sport).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,15)
                    //
                    //                AppButton(title: StringConstants.none,buttonType: .dropDown) {
                    //
                    //                }
                    
                    Text(StringConstants.selectGames).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,10)
                    
                    Text(StringConstants.selectMinimum).font(Font.mulishRegular(size: 13)).foregroundColor(Color.textColorGray)
                    PreferencesViewButtons(favoriteSportsList: viewModel.favoriteSportsList, callBack: {index in
                        viewModel.favoriteSportsList?[index].userFav?.toggle()
                        if let item = viewModel.favoriteSportsList?[index]{
                            viewModel.btnSaveChanges(sportsItem: item)
                        }
                    })
                    //  FavoriteSportsView(favoriteSportsList: favoriteSportsList, favoriteSportsName: favoriteSportsName).padding(.top,15)
                    
                    Text(StringConstants.location).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,15)
                    
                    AppButton(title: StringConstants.locName,buttonType: .dropDown) {
                      
                        // viewModel.changePreference(sport_id: 0, action: true)
                    }
                    
                    AppButton(title: StringConstants.saveChanges) {
                       
                        
                    }.padding(.top,55)
                    Spacer()
                }.padding(.horizontal).onAppear{
                   // viewModel.getPreference()
                    viewModel.favoriteSportsList =  BaseData.shared.favoriteSportsList
                }
            }
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType)
           
    }
}

#Preview {
   PreferencesView(viewModel: PreferencesViewModel())
    //GolfCardView()
}
struct GolfCardView: View {
    
    var body: some View {
        
        VStack(spacing: 0){
            HStack(spacing: 0) {
                ForEach(0..<4, id: \.self) { row in
                    
                    Text("1").frame(width: row == 0 ? 60 : row == 1 ? 60 : 100,height: 60)
                        .foregroundColor(Color.white)
                    if row != 3{
                        Divider().frame(height: 60).background(Color.white)
                            .padding(.leading, row > 1 ? 20 : 0 )
                    }
                }
                Spacer()
            }.frame(maxWidth: .infinity).background(Color.appGreen).cornerRadius(15, corners: [.topLeft,.topRight]).padding(.horizontal)
            VStack(spacing: 0){
                ForEach(0..<11, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<6) { col in
                            let itemIndex = row * 6 + col
                            Text("").frame(width: 60,height: 60)
                                .overlay(
                                    RoundedCorner(radius: itemIndex == 60 ? 20 : itemIndex == 65 ? 20 : 0, corners:  itemIndex == 60 ? [.bottomLeft] : itemIndex == 65 ? [.bottomRight] : [.bottomLeft])
                                        .stroke(Color.appGray, lineWidth: 1))
                                .background(row % 2 == 0 ? Color.white : Color.textFieldColor)
                        }
                    }
                }
            }
        }
    }
}
