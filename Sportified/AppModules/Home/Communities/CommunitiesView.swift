//
//  CommunitiesView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI
import Combine

struct CommunitiesView: View {
    
    @ObservedObject var viewModel: CommunitiesViewModel
    var body: some View {
        ZStack{
            VStack{
                
                HomeAppBar(bgColor: .appGreen,height:90,foregroundColor: .white,image: .ic_BellWight,imageArrow: .ic_ArrowDownWight) { image in
                    viewModel.fullImage = image
                    viewModel.showProfile.toggle()
                }
                
                VStack{
                    
                    AuthTextField(title: StringConstants.albert,type: .searchField, text: $viewModel.txtSearch).padding(.top,5)
                        
                    if UserDefaultsManager.shared.userProfileData?.role == UserType.organize.rawValue{
                        CreateNewGroupButton(title: StringConstants.createNewGroup,callBack: {
                            viewModel.coordinator?.loadCreateGroupView(callback: { data in
                                
                                viewModel.getAllChatsResponse = data.results ?? []
                            })

                        }).padding(.top)
                    }
                    ScrollView(showsIndicators: false){
                        
                        VStack(spacing: 5){
                            if let list = viewModel.temcommunitiesList{
                                ForEach(0..<list.count, id: \.self){ index in
                                    let item = list[index]
                                    GroupsListView(item: item,shownotification: false)
                                        .onTapGesture {
                                                viewModel.coordinator?.loadChatView(item: item,callBack: { massage in
                                                    var tempItem = viewModel.temcommunitiesList?[index]
                                                    tempItem?.lastMessage = massage
                                                    viewModel.temcommunitiesList?.remove(at: index)
                                                    viewModel.temcommunitiesList?.insert(tempItem!, at: 0)
                                                })
                                            if item.joined ?? false{
                                                viewModel.temcommunitiesList?[index].showNotifection = false
                                                viewModel.temcommunitiesList?[index].unReadMessage = 0
                                            }else{
                                                viewModel.validationText = "Please join our community"
                                            }
                                        }
                                }
                            }
                        }.padding(.top,5)
                        
                       
                        Text("Groups").font(Font.mulishMedium(size: 15))
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.vertical,10)
                    
                        if let list = viewModel.getAllChatsResponse{
                            VStack(spacing: 5){
                                ForEach(0..<list.count,id: \.self){ index in
                                    let item = list[index]
                                    GroupsListView(item: item,shownotification: false)
                                        .onTapGesture {
                                           
                                            viewModel.coordinator?.loadChatView(item: item,callBack: { massage in
                                                var tempItem = viewModel.getAllChatsResponse?[index]
                                                tempItem?.lastMessage = massage
                                                viewModel.getAllChatsResponse?.remove(at: index)
                                                viewModel.getAllChatsResponse?.insert(tempItem!, at: 0)
                                               
                                            })
                                            viewModel.getAllChatsResponse?[index].showNotifection = false
                                            viewModel.getAllChatsResponse?[index].unReadMessage = 0
                                        }
                                }
                            }.padding(.top,5)
                        }
                        
                        if UserDefaultsManager.shared.userProfileData?.role == UserType.organize.rawValue{
                            NearbyGamesScecondListView(buttonType: .communities) {
                                viewModel.coordinator?.loadCreatGame( callBackUpdateData: {_ in})
                            }
                        }
                        
                    }.padding(.top,5)
                    
                    Spacer()
                }.padding(.horizontal)
                
            }
            
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
            if viewModel.showProfile{
                withAnimation{
                    FullScreenImageView(image:viewModel.fullImage ,isShow: $viewModel.showProfile)
                }
            }
        }.edgesIgnoringSafeArea(.top).showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert,toastType: viewModel.toastType)
            .onAppear{
                if !WebSocketManager.shared.checkWebSocketConnected(){
                    WebSocketManager.shared.connect()
                }
        }.onDisappear{
          // WebSocketManager.shared.disconnect()
        }
    }
}

#Preview {
    CommunitiesView(viewModel: CommunitiesViewModel())
}
