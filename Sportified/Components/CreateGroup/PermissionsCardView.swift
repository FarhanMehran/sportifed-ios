//
//  PermissionsCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import SwiftUI

struct PermissionsCardView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text(StringConstants.members).font(Font.mulishMedium(size: 16)).foregroundColor(Color.textColorGray)
            HStack{
                Image.ic_edit
                
                Text(StringConstants.editGroupSettings).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
               
                Spacer()
                Image.ic_SwitchOn
              
            }
            Text(StringConstants.membersCanChangeName).font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColorGray).frame(width: 200)
                .padding(.leading,12).padding(.horizontal)
            
  
            HStack{
                Image.ic_Cha
                
                Text(StringConstants.sendMessages).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
               
                Spacer()
                Image.ic_SwitchOn
              
            }
            
            Text(StringConstants.admin).font(Font.mulishMedium(size: 16)).foregroundColor(Color.textColorGray)
            HStack{
                Image.ic_Adme
                
                Text(StringConstants.approveNewMembers).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
               
                Spacer()
                Image.ic_SwitchOn
              
            }
            Text(StringConstants.whenTurnedon).font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColorGray).frame(width: 200)
                .padding(.leading,12).padding(.horizontal)
            
        }.padding(.horizontal,10).frame(maxWidth: .infinity).frame(height: 327).background(Color.white).overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.appGrayColor, lineWidth: 1))
    }
}

#Preview {
    PermissionsCardView()
}
