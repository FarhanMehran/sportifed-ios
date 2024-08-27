//
//  CreatTournamentView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/06/2024.
//

import SwiftUI

struct CreatTournamentView: View {
    
    @ObservedObject var viewModel: CreatTournamentViewModel
    
    var body: some View {
        ZStack{
           
                VStack{
                    HomeSecondaryAppBBar(title: StringConstants.creatTournament, btnBackCallBack: {
                        viewModel.coordinator?.popNavigationView()
                    }).padding(.top,5)
                    ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        Text(StringConstants.name).font(Font.mulishMedium(size: 18)).padding(.top,20).foregroundColor(Color.textColor)
                        AuthTextField(title: StringConstants.exCricketMatch,type: .normalField ,text: $viewModel.name)
                        
                        Text(StringConstants.description).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,5)
                        
                        HStack {
                            AutoResizableTextView(text: $viewModel.description)
                            
                            
                        }.padding().frame(height: 175).background(Color.textFieldColor).cornerRadius(10)
                        
                        Text(StringConstants.sport).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,5)
                        AppButton(title: viewModel.sport?.name ?? "",buttonType: .dropDown) {
                            viewModel.showDropDown.toggle()
                        }
                        AppButton(title: StringConstants.create, callBack: {
                            viewModel.btnCreatToutnament()
                        }).padding(.top,30)
                    }.padding(.horizontal)
                }
            }
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
        }.onAppear{
            viewModel.getSports()
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType).popover(isPresented: $viewModel.showDropDown) {
            ScrollView{
                VStack(spacing: 20){
                    DropDownTitle(text: "Select Sport")
                    
                    if let list = viewModel.favoriteSportsList{
                        ForEach(list, id: \.self) { item in
                            DropDownText(text: item.name ?? "", callBack: {
                                viewModel.sport = item
                                viewModel.showDropDown.toggle()
                            })
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CreatTournamentView(viewModel: CreatTournamentViewModel())
}
