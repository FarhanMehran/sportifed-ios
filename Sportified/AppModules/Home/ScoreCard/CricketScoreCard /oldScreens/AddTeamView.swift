//
//  Add Team.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/07/2024.
//

import SwiftUI

struct AddTeamView: View {
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                
                HomeSecondaryAppBBar(title: StringConstants.addTeam,showUndoButton: true, btnShareCallBack:  {
                    
                }).padding(.top,5)
                
                VStack{
                    Image.ic_add.resizable().frame(width: 100,height: 100).padding(.top,20)
                    Text(StringConstants.teamLogo).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                    VStack(alignment: .leading){
                        
                        HStack(spacing: 2){
                            Text(StringConstants.teamName).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }
                        AuthTextField(title: StringConstants.enterTeamName,type: .normalField ,text: .constant(""))
                        
                        HStack(spacing: 2){
                            Text(StringConstants.cityTown).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }
                        
                        AuthTextField(title: StringConstants.enterYourCity,type: .normalField ,text: .constant(""))
                        
                        Text(StringConstants.teamCaptainNameOptional).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                        AuthTextField(title: StringConstants.enterCaptainName,type: .normalField ,text: .constant(""))
                        
                        Text(StringConstants.phoneNumberOptional).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                        HStack {
                            HStack{
                                Text("+92").font(Font.mulishRegular(size: 14)).foregroundColor(Color.textColorGray)
                                Image.ic_arrowDown
                                Color.textColorGray.frame(width: 1,height: 38)
                            }.onTapGesture {
                                //viewModel.showCountryCodePicker.toggle()
                            }
                            TextField(StringConstants.teamCaptionCoordinator, text:.constant("")).foregroundColor(Color.textColorGray).font(Font.mulishMedium(size: 14))
                              
                            
                        }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10).padding(.top,5)
                    }.padding(.top,20).padding(.horizontal)
                    
                }.padding(.bottom).overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.appGrayColor, lineWidth: 1)).padding(.horizontal)
                
                AppButton(title: StringConstants.addTeam, callBack: {})
            }
        }
    }
}

#Preview {
    AddTeamView()
}
