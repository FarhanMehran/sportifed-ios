//
//  ChatView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import SwiftUI


struct ChatView: View {
    
    @ObservedObject var viewModel: ChatViewModel
    @State var fieldHight:CGFloat = 43
    @State private var text: String = "Initial Text"
    var body: some View {
        
        ZStack{
            VStack{
                HomeSecondaryAppBBar(title: viewModel.item?.name ?? "", showChatBar: true,btnBackCallBack:   {
                    viewModel.coordinator?.popNavigationView()
                }).padding(.top,5)
                
                VStack{
                    
                    ScrollView(showsIndicators: false){
                        
                        
                        ForEach(0..<(viewModel.chatListDic?.count ?? 0), id: \.self) { index in
                            
                            Text(viewModel.chatListDic?[index].0 ?? "")
                            ForEach(0..<(viewModel.chatListDic?[index].1.count ?? 0) , id: \.self){ indexs in
                                if  let item = viewModel.chatListDic?[index].1[indexs]{
                                    if UserDefaultsManager.shared.userProfileData?.id == item.sender?.id || UserDefaultsManager.shared.userProfileData?.fullName == item.sender?.fullName{
                                        UserChatLayout(userName: item.sender?.fullName ??  "",massage: item.message ?? "" ,time: item.createdAt?.to12HourFormat ?? "",showTimeIcon: item.sender?.isSend ?? false)
                                    }else{
                                        ChatViewLayOut(userName: item.sender?.fullName ??  "",massage: item.message ?? "" ,time: item.createdAt?.to12HourFormat ?? "")
                                    }
                                }
                            }
                        }

                    }
                    
                    Spacer()

                    HStack{
                 
                        ResizableTextView(text: $viewModel.txtMassage, hight: $fieldHight)
                            .frame(maxWidth: UIScreen.main.bounds.width - 125,minHeight: 43,maxHeight: fieldHight > 150 ? 150 : fieldHight)
                            .padding(.horizontal)
                            .padding(.top,8)
                            .background(Color.textFieldColor)
                            .cornerRadius(15)
                        
                        Spacer()
                    }
                    
                }.padding(.horizontal)
            }
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        viewModel.sendMassage()
                    }, label: {
                        ZStack{
                            Color.appGreen.frame(width: 50,height: 50).clipShape(.circle)
                            Image.ic_SendSMS
                        }
                    })
                }
            }.padding(.trailing)
            
            
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
            
        }.onAppear{
           
            if !WebSocketManager.shared.checkWebSocketConnected(){
                WebSocketManager.shared.connect()
            }
            viewModel.getChat()
        }
    }
}

#Preview {
    UserChatLayout()
}

struct ChatViewLayOut: View {
    
    var userType: ChatUserype = .community
    var userName = "Hi!"
    var massage = "Hi!"
    var time = "12:20 AM"
    var img:String = ""
    var showTimeIcon:Bool = false
    var body: some View {
        
        VStack(alignment: userType == .community ? .leading : .trailing,spacing: 5){
           
                //if userType == .community{
            WebImageView(image: "")
                .frame(width: 70,height: 50)
                .frame(maxWidth: .infinity,alignment: userType == .community ? .leading : .trailing)
                        .offset(y:30)
              //  }
                VStack(alignment: .leading, spacing: 5){
                    
                    Text(userName).font(Font.mulishRegular(size: 16)).foregroundColor(userType == .ownUser ? Color.white : Color.appGreen.opacity(0.5))
                    
                    Text(massage).font(Font.mulishRegular(size: 20)).foregroundColor(userType == .ownUser ? Color.white : Color.textColor)
                    
                    HStack{
                        Spacer()
                        Text(time).font(Font.mulishRegular(size: 12))
                            .foregroundColor(userType == .ownUser ? Color.white.opacity(0.5) : Color.textColor.opacity(0.5))
                    }
                    
                }.frame(width: massage.count > 13 ? .infinity : 133).padding(.horizontal,10).padding(.vertical,5)
                    .background(userType == .ownUser ? Color.appGreen : Color.textFieldColor)
                    .cornerRadius(12).padding( userType != .ownUser ? .leading : .trailing, 70)
               
                    .offset(y: -30)
        }
    }
}


struct UserChatLayout: View {
    
    var userType: ChatUserype = .ownUser
    var userName = "Hi!"
    var massage = "Hi!"
    var time = "12:20 AM"
    var img:String = ""
    var showTimeIcon:Bool = false
    var body: some View {
        
        VStack(alignment: userType == .community ? .leading : .trailing,spacing: 5){
           
                //if userType == .community{
            WebImageView(image: "")
                .frame(width: 70,height: 50)
                .frame(maxWidth: .infinity,alignment: userType == .community ? .leading : .trailing)
                        .offset(y:30)
              //  }
                VStack(alignment: .leading, spacing: 5){
                    
                    Text(userName).font(Font.mulishRegular(size: 16)).foregroundColor(userType == .ownUser ? Color.white : Color.appGreen.opacity(0.5))
                    
                    Text(massage).font(Font.mulishRegular(size: 20)).foregroundColor(userType == .ownUser ? Color.white : Color.textColor)
                    
                    HStack{
                        Spacer()
                        if showTimeIcon{
                            Image(systemName: "stopwatch")
                                .resizable()
                                .frame(width: 14,height: 14)
                                .foregroundColor(userType == .ownUser ? Color.white.opacity(0.6) : Color.textColor.opacity(0.6))
                        }else{
                            Text(time).font(Font.mulishRegular(size: 12))
                                .foregroundColor(userType == .ownUser ? Color.white.opacity(0.6) : Color.textColor.opacity(0.6))
                        }
                    }
                    
                }.frame(width: massage.count > 13 ? .infinity : 133).padding(.horizontal,10).padding(.vertical,5)
                    .background(userType == .ownUser ? Color.appGreen : Color.textFieldColor)
                    .cornerRadius(12).padding( userType != .ownUser ? .leading : .trailing, 70)
               
                    .offset(y: -30)
        }
    }
}


