//
//  CreateGroupView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI

struct CreateGroupView: View {
    
    @ObservedObject var viewModel: CreateGroupViewModel
    
    var body: some View {
        ZStack{
            VStack{
                HomeSecondaryAppBBar(title: StringConstants.createGroup, btnBackCallBack:   {
                    viewModel.coordinator?.popNavigationView()
                }).padding(.top,5)
                
                VStack{
                    
                    HStack{
                        ZStack{
                            
                            Image.ic_camra.resizable().frame(width: 20,height: 20)
                        }.frame(width: 60,height: 50).background(Color.textFieldColor).clipShape(Circle()).shadow(color: .white, radius: 0.5, x: 0, y: 0)
                        VStack(alignment: .leading){
                            TextField(StringConstants.groupName, text: $viewModel.groupName).foregroundColor(Color.textColor).font(Font.mulishMedium(size: 14))
                                .autocapitalization(.none)
                            
                            CustomDivider().padding(.trailing)
                        }
                        Spacer()
                    }.padding(.leading).frame(maxWidth: .infinity).frame(height: 100).background(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appGrayColor, lineWidth: 1)).padding(.top)
                    
                    HStack{
                        Text(StringConstants.addMembers).font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor).padding(.top,10)
                        Spacer()
                    }
                    
                    //Searchview
                    AuthTextField(title: StringConstants.albert,type: .searchField, text: $viewModel.txtSearch)
                    
                    ScrollView(showsIndicators: false){
                        if let data = viewModel.tempgetAllUserList?.data {
                           ForEach(0..<data.count,id: \.self){index in
                                
                               CreateGroupViewListItem(userModel: viewModel.tempgetAllUserList?.data![index],callBack: {
                                    self.viewModel.tempgetAllUserList?.data?[index].isSelected?.toggle()
                                    
                                    if viewModel.tempgetAllUserList?.data?[index].isSelected ?? false {
                                        viewModel.userID?.append(viewModel.tempgetAllUserList?.data?[index].id ?? 0)
                                        
                                        
                                    } else {
                                        
                                        if let idToRemove = viewModel.tempgetAllUserList?.data?[index].id,
                                           let indexToRemove = viewModel.userID?.firstIndex(of: idToRemove) {
                                            viewModel.userID?.remove(at: indexToRemove)
                                        }
                                    }
                                    
                                })
                           }
                        }
                    }.padding(.top)
                    
                    Spacer()
                    
                    AppButton(title: StringConstants.create) {
                        viewModel.btnCreateGroup()
                    }
                    
                }.padding(.horizontal)
            }
            
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType).onAppear{
            viewModel.getAllUser()
        }
    }
}

#Preview {
    CreateGroupView(viewModel: CreateGroupViewModel())
}

struct CreateGroupViewListItem: View {
    
    var userModel:GetUserData?
    var callBack:(() -> Void)
    var body: some View {
        VStack(spacing: 15){
           
            HStack{
                Image.ic_User.resizable().frame(width: 50,height: 50)
                Text(userModel?.name ?? "").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.horizontal,4)
                Spacer()
                if userModel?.isSelected ?? false{
                    ZStack{
                        Color.appGreen.frame(width: 30,height: 30).clipShape(.circle)
                        Image.ic_Tick
                    }
                }
            }
        }.background(Color.white.opacity(0.001)).onTapGesture {
         
                callBack()
            
        }
    }
}
