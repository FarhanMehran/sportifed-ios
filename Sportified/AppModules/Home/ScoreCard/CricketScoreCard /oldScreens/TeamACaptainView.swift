//
//  TeamACaptainView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/07/2024.
//

import SwiftUI

struct TeamACaptainView: View {
    var body: some View {
        
        
        VStack{
            
            HomeSecondaryAppBBar(title: StringConstants.teamCaptain,showUndoButton: true, btnShareCallBack:  {
                
            }).padding(.top,5)
            VStack{
                HStack(spacing: 20){
                    Text("Captain")
                        .font(.mulishMedium(size: 15))
                        .padding(.horizontal).frame(height: 35)
                        .foregroundColor(Color.white)
                        .background(Color.appGreen)
                        .cornerRadius(15)
                    Text("Wicket Keeper")
                        .font(.mulishMedium(size: 15))
                        .padding(.horizontal).frame(height: 35)
                        .foregroundColor(Color.textColorGray)
                        .background(Color.textFieldColor)
                        .cornerRadius(15)
                    Text("12th Man")
                        .font(.mulishMedium(size: 15))
                        .padding(.horizontal).frame(height: 35)
                        .foregroundColor(Color.textColorGray)
                        .background(Color.textFieldColor)
                        .cornerRadius(15)
                }
                
                ScrollView(showsIndicators: false){
                    VStack(spacing: 10){
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
                    }.padding(.top)
                }
            }.padding(.horizontal)
            AppButton(title: StringConstants.next, callBack: {}).padding(.horizontal)
           Spacer()
        }
        
    }
}

#Preview {
    TeamACaptainView()
}
