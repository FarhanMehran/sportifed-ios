//
//  SelectPlayingTeamsView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/07/2024.
//

import SwiftUI

struct SelectPlayingTeamsView: View {
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                
                HomeSecondaryAppBBar(title: StringConstants.selectPlayingTeams,showUndoButton: true, btnShareCallBack:  {
                    
                }).padding(.top,5)
                
             
                Image.ic_add.resizable().frame(width: 50,height: 50).padding(.top,100)
                AppButton(title: StringConstants.selectTeamA, callBack: {}).frame(width: 250,height: 50).padding(.top,10)
                
                Image.ic_vs.padding(.top,30)
                
                Image.ic_add.resizable().frame(width: 50,height: 50).padding(.top,20)
                AppButton(title: StringConstants.selectTeamB, callBack: {}).frame(width: 250,height: 50).padding(.top,10)
                
            }
        }
    }
}

#Preview {
    SelectPlayingTeamsView()
}
