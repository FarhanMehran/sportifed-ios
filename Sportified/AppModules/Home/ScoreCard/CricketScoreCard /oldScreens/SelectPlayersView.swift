//
//  SelectPlayersView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/07/2024.
//

import SwiftUI

struct SelectPlayersView: View {
    var body: some View {
        
        VStack{
            
            HomeSecondaryAppBBar(title: StringConstants.selectPlayers,showUndoButton: true, btnShareCallBack:  {
                
            }).padding(.top,5)
            VStack{
                HStack{
                    HStack {
                        Button {
                            
                        } label: {
                            Image.ic_Search.foregroundColor(Color.textColorGray).font(Font.mulishBold(size: 12))
                        }
                        
                        TextField(StringConstants.quickSearch, text: .constant("")).foregroundColor(Color.textColorGray).font(Font.mulishMedium(size: 14))
                    }.padding(.horizontal).frame(height: 40).overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appGrayColor, lineWidth: 1))
                    Button {
                        
                    } label: {
                        HStack{
                            Image.ic_addwight
                            Text(StringConstants.addPlayer)
                                .font(.mulishBold(size: 15))
                            Spacer()
                        }.padding(.leading).frame(maxWidth: 140).frame(height: 40)
                            .foregroundColor(Color.white)
                            .background(Color.appGreen)
                            .cornerRadius(5)
                    }
                    
                }
                
                Text(StringConstants.selectAll)
                    .font(.mulishMedium(size: 15)).foregroundColor(.appGreen)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .padding(.top,10)
                ScrollView(showsIndicators: false){
                    ForEach(0..<2, id: \.self){index in
                        HStack{
                            Image.ic_addPlayer
                            Text(StringConstants.selectAll)
                                .font(.mulishMedium(size: 15)).foregroundColor(.textColor)
                                .padding(.leading)
                            Spacer()
                            CheckButton()
                        }.padding(.horizontal).frame(height: 60).background(Color.textFieldColor)
                            .cornerRadius(5)
                    }
                }
                
                Spacer()
                AppButton(title: StringConstants.next, callBack: {})
                
            }.padding(.horizontal).padding(.top)
        }
    }
}

#Preview {
    SelectPlayersView()
}
