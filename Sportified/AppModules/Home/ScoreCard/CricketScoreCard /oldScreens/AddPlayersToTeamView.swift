//
//  AddPlayersToTeamView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 15/07/2024.
//

import SwiftUI

struct AddPlayersToTeamView: View {
    var body: some View {
        VStack{
            
            HomeSecondaryAppBBar(title: StringConstants.teamCaptain,showUndoButton: true, btnShareCallBack:  {
                
            }).padding(.top,5)
            ScrollView{
                VStack(spacing: 20){
                    VStack(alignment: .leading){
                        HStack(spacing:20){
                            Image("ic_copy 1")
                            VStack(alignment: .leading,spacing: 5){
                                Text(StringConstants.teamLink).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                                Text(StringConstants.easiestWayToAddPlayers).font(Font.mulishMedium(size: 13)).foregroundColor(Color.textColorGray)
                                
                            }
                        }
                        
                        Text("Share this link with captain and let them add their respective players directly to the team.").font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColorGray).padding(.top)
                        HStack{
                            Image("btnShare")
                            Image("btnWhatapp")
                        }.padding(.top)
                    }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appGrayColor, lineWidth: 1))
                    
                    VStack(alignment: .leading){
                        Image("addEamil")
                    }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appGrayColor, lineWidth: 1))
                    VStack(alignment: .leading){
                        Image("addContext")
                    }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appGrayColor, lineWidth: 1))
                    VStack(alignment: .leading){
                        Image("addQR")
                    }.frame(maxWidth: .infinity).padding(.horizontal,10).padding(.vertical).background(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appGrayColor, lineWidth: 1))
                    
                }.padding(.horizontal)
            }
            Spacer()
        }
    }
}

#Preview {
    AddPlayersToTeamView()
}
