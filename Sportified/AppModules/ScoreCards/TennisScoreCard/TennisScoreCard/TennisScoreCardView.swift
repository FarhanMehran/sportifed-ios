//
//  TennisScoreCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 19/08/2024.
//

import SwiftUI

struct TennisScoreCardView: View {
    @ObservedObject var viewModel: TennisScoreCardViewModel
    var body: some View {
        VStack(spacing: 0){
            HomeSecondaryAppBBar(title: "Match Management",showUndoButton: true, btnShareCallBack:  {
                
            }).padding(.top,5)
            ScrollView{
                SetView()
                VStack(spacing: 20){
                    
                    HStack(spacing: 2){
                        Text("Current Game").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                        Text("").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }.padding(.top,25)
             
                    CustomDropDown(title: viewModel.currentGame ?? "Game 1",
                                   isShow: $viewModel.isShowcurrentGame,
                                   list: viewModel.currentGameList,
                                   callBack: {name,index in
                        
                        viewModel.currentGameList = viewModel.currentGameList.map { user in
                            var updatedUser = user
                            updatedUser.isSelected = false
                            return updatedUser
                        }
                        viewModel.currentGameList[index].isSelected = true
                        viewModel.currentGame = name
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.isShowcurrentGame.toggle()
                        }
                    })
                    
                    TeamCardView()
                    //.padding(.top,cardType == .TennisScoreCard ? 0 : 100)
                    HStack{
                        ButtonCardView()
                        Spacer()
                        ButtonCardView()
                    }
                    
                    HStack(spacing: 2){
                        Text("Game Status").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                        Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                    
                    HStack {
                        Text("Deuce").foregroundColor(Color.textColor).font(Font.mulishMedium(size: 16))
                        Spacer()
                        
//                        Image(viewModel.isShowHandicap ? "ons" : "offs").onTapGesture {
//                            viewModel.isShowHandicap.toggle()
//                        }
                        
                    }.padding().frame(height: 60).background(Color.textFieldColor).cornerRadius(10)
                    
                    
                    HStack(spacing: 2){
                        Text("Advantage").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                        Text("").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
             
                    CustomDropDown(title: viewModel.advantage ?? "Player 1",
                                   isShow: $viewModel.isShowAdvantage,
                                   list: viewModel.advantageList,
                                   callBack: {name,index in

                        viewModel.advantageList = viewModel.advantageList.map { user in
                            var updatedUser = user
                            updatedUser.isSelected = false
                            return updatedUser
                        }
                        viewModel.advantageList[index].isSelected = true
                        viewModel.advantage = name
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.isShowAdvantage.toggle()
                        }
                    })
                    
                    
                    HStack(spacing: 2){
                        Text("Serving").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                        Text("").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
             
                    CustomDropDown(title: viewModel.advantage ?? "Player 1",
                                   isShow: $viewModel.isShowAdvantage,
                                   list: viewModel.advantageList,
                                   callBack: {name,index in

                        viewModel.advantageList = viewModel.advantageList.map { user in
                            var updatedUser = user
                            updatedUser.isSelected = false
                            return updatedUser
                        }
                        viewModel.advantageList[index].isSelected = true
                        viewModel.advantage = name
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.isShowAdvantage.toggle()
                        }
                    })
                    
                    SetCardView()
                    HStack{
                        ButtonCardView()
                        Spacer()
                        ButtonCardView()
                    }
                    
                    SetCardView(title: "Sets won")
                    HStack{
                        ButtonCardView()
                        Spacer()
                        ButtonCardView()
                    }
                    
                    SetCardView(title: "Tiebreaker Status")
                    HStack{
                        ButtonCardView()
                        Spacer()
                        ButtonCardView()
                    }
                    
                    
                    Spacer()
                    AppButton(title: "Complete Match") {
                        
                    }
                }.padding(.horizontal)
            }
        }
    }
}

#Preview {
    TennisScoreCardView(viewModel: TennisScoreCardViewModel())
}
