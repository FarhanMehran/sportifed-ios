//
//  StartMatchView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 15/07/2024.
//

import SwiftUI

struct StartCircketMatchView: View {
    @ObservedObject var viewModel: StartCircketMatchViewModel
    var favoriteSportsList = ["Rough", "Cement","Turf","Astroturf","Matting"]
    var ballType = ["Tennis", "Leather","Hard","Other"]
    var isSelectItem = 1
    var body: some View {
        ZStack{
            VStack{
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator,title: "Start a Match",showUndoButton: true, btnShareCallBack:  {
                    
                }).padding(.top,5)
                ScrollView{
                    HStack{
                        VStack{
                            HStack{
                                WebImageView(image: viewModel.nearbyMatchesitem?.teams?.first?.img ?? "Team A",placeholder: Image("Hard"))
                                    .frame(width: 100,height: 100)
                            }.frame(width: 100,height: 100).background(Color.appGray).clipShape(.circle)
                            
                            ListButton(title: viewModel.nearbyMatchesitem?.teams?.first?.name ?? "Team A", callBack: {}).padding(.horizontal)
                        }
                        Image.ic_vs.padding(.bottom,30)
                        VStack{
                            HStack{
                                WebImageView(image: viewModel.nearbyMatchesitem?.teams?.last?.img ?? "Team A",placeholder: Image("Hard"))
                                    .frame(width: 100,height: 100)
                            }.frame(width: 100,height: 100).background(Color.appGray).clipShape(.circle)
                            
                            ListButton(title: viewModel.nearbyMatchesitem?.teams?.last?.name ?? "Team b", callBack: {}).padding(.horizontal)
                        }
                        
                    }.padding(.top,30)
                    VStack(alignment: .leading){
                        HStack(spacing: 2){
                            Text("Match Type").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,25)
                        HStack{
                            ListButton2(title: "Limited Overs", callBack: {})
                            ListButton2(title: "Box/ Turf Cricket",bgColor: .textFieldColor,foregroundColor: .textColor ,callBack: {})
                            ListButton2(title: "Pair Cricket",bgColor: .textFieldColor,foregroundColor: .textColor ,callBack: {})
                            
                        }
                        HStack{
                            ListButton2(title: "Test Match",bgColor: .textFieldColor,foregroundColor: .textColor ,callBack: {})
                            ListButton2(title: "The Hundred",bgColor: .textFieldColor,foregroundColor: .textColor ,callBack: {})
                            
                            
                        }.padding(.top,5)
                        
                        
                        
                        HStack(spacing: 20){
                            VStack(alignment: .leading){
                                HStack(spacing: 0){
                                    TextField("No of Overs", text: $viewModel.noOfOvers) .foregroundColor(.gray) .font(.mulishRegular(size: 12.0))
                                    Text("*") .foregroundColor(.red) .font(.mulishRegular(size: 12.0))
                                }
                                Color.gray.frame(height: 1)
                            }.frame(width: 100)
                            VStack(alignment: .leading){
                                HStack(spacing: 0){
                                    
                                    TextField("Overs Per Bowler", text: $viewModel.oversPerBowler) .foregroundColor(.gray) .font(.mulishRegular(size: 12.0))
                                }
                                Color.gray.frame(height: 1)
                            }.frame(width: 100)
                        }.padding(.top,25)
                        HStack(spacing: 2){
                            Text("Ball Type").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                            Image("ball_or").padding(.leading)
                        }.padding(.top,25)
                        
                        HStack(spacing: 20){
                            ForEach(0..<ballType.count, id: \.self) { row in
                                
                                VStack(spacing: 10){
                                    Image(ballType[row]).resizable().padding(12).frame(width: 60,height: 60).overlay(
                                        RoundedRectangle(cornerRadius: 108)
                                            .stroke(Color.gray, lineWidth: 2))
                                    Text(ballType[row]) .foregroundColor(.gray) .font(.mulishRegular(size: 12.0))
                                }
                                
                            }
                        }
                        
                        HStack(spacing: 2){
                            Text("Pitch Type").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,25)
                        
                        
                        ForEach(favoriteSportsList.indices, id: \.self) { row in
                            HStack(spacing: 10) {
                                ForEach(0..<3) { col in
                                    let itemIndex = row * 3 + col // Calculate the item index
                                    if itemIndex < favoriteSportsList.count {
                                        let item = favoriteSportsList[itemIndex]
                                        Text(item)
                                            .padding()
                                        
                                            .frame(width: 100,height: 28)
                                            .foregroundColor(isSelectItem == itemIndex ? .white : .textColor)
                                            .background(isSelectItem == itemIndex ? Color.appGreen : .textFieldColor)
                                            .cornerRadius(10)
                                            .font(.mulishMedium(size: 14.0))
                                    }
                                }
                            }
                        }
                    }
                    
                    AppButton(title: "Next (Toss)", callBack: {
                        viewModel.btnClick()
                        
                    }).padding(.top,50).padding(.horizontal)
                    
                    
                }
            }.onAppear{
               // viewModel.test()
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert)
    }
}

#Preview {
    StartCircketMatchView(viewModel: StartCircketMatchViewModel())
}
