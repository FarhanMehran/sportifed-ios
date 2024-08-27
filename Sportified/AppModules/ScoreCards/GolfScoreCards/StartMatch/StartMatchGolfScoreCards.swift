//
//  StartMatchGolfScoreCards.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/08/2024.
//

import SwiftUI

struct StartMatchGolfScoreCards: View {
    @ObservedObject var viewModel: StartMatchGolfScoreCardsModel
    var body: some View {
        ZStack{
            VStack{
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator,title: "Start a Match",showUndoButton: true, btnShareCallBack:  {
                    
                }).padding(.top,5)
                ScrollView(showsIndicators: false){
               
                    
                    VStack(alignment: .leading){
                        
                        HStack(spacing: 2){
                            Text("Select Match Format").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }.padding(.top,25)
                 
                        CustomDropDown(title: viewModel.golfers ?? "Golfers",
                                       isShow: $viewModel.isShowGolfers,
                                       list: viewModel.golfersList,
                                       callBack: {name,index in
                            
                            viewModel.golfersList = viewModel.golfersList.map { user in
                                var updatedUser = user
                                updatedUser.isSelected = false
                                return updatedUser
                            }
                            viewModel.golfersList[index].isSelected = true
                            viewModel.golfers = name
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.isShowGolfers.toggle()
                            }
                        })
                        
                        HStack(spacing: 2){
                            Text("Number of Holes").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }.padding(.top,15)
                 
                        VStack{
                            HStack(spacing: 20){
                      Spacer()
                                CircleBuuton(toggle: .constant(false))
                                Text("9 holes").font(Font.mulishRegular(size: 18)).foregroundColor(Color.textColorGray)
                                CircleBuuton(toggle: .constant(false))
                                Text("18 holes").font(Font.mulishRegular(size: 18)).foregroundColor(Color.textColorGray)
                                Spacer()
                                
                            }.padding()
                     
                        }.frame(height: 50).background(Color.textFieldColor).cornerRadius(10)
          
                        
                        
                        HStack(spacing: 2){
                            Text("Select Playing Holes").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }.padding(.top,15)
                 
                        VStack{
                            Text("Front Nine").font(Font.mulishRegular(size: 18)).foregroundColor(Color.textColor).padding(.top,5) .frame(maxWidth: .infinity,alignment: .leading)
                            HStack{
                                ButtonCardView2(title: "1 - 9")
                                Spacer()
                                ButtonCardView2(title: "10 - 18")
                                Spacer()
                                ButtonCardView2(title: "19 - 27")
                            }.padding(.top,5)
                        }
                        
                        VStack{
                            Text("Back Nine").font(Font.mulishRegular(size: 18)).foregroundColor(Color.textColor).padding(.top,5) .frame(maxWidth: .infinity,alignment: .leading)
                            HStack{
                                ButtonCardView2(title: "1 - 9")
                                Spacer()
                                ButtonCardView2(title: "10 - 18")
                                Spacer()
                                ButtonCardView2(title: "19 - 27")
                            }.padding(.top,5)
                        }
                        
                       
                        HStack(spacing: 2){
                            Text("Additional Options").font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }.padding(.top,25)
                        
                        HStack {
                            Text("Par").foregroundColor(Color.textColor).font(Font.mulishMedium(size: 16))
                            Spacer()
                            
                            Image(viewModel.isShowHandicap ? "ons" : "offs").onTapGesture {
                                viewModel.isShowHandicap.toggle()
                            }
                            
                        }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10)
                    }
                    
                    AppButton(title: "Next", callBack: {
                        viewModel.btnClick()
                        
                    }).padding(.top,50)
                    
                    
                }.padding(.horizontal)
            }.onAppear{
               // viewModel.test()
            }
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert)
    }
}

#Preview {
    StartMatchGolfScoreCards(viewModel: StartMatchGolfScoreCardsModel())
}
struct ButtonCardView2: View {
    var title:String = "+"
    var width:CGFloat = 105
    var body: some View {
        Button {
            
        } label: {
            
            Text(title).offset(y:-3).font(.mulishMedium(size: 15))
                .frame(height: 45)
            
                .foregroundColor(Color.appGreenColor)
                .frame(width: width).overlay(RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.appGreen, lineWidth: 1))
            
        }

        
    }
}
