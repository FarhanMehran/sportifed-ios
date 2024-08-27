//
//  GroupsListView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct GroupsListView: View {
    var item:GetlCommunityResponce?
    var shownotification = false
    var showAddButton = false
    var body: some View {
        HStack{
            ZStack{
                Image.ic_Men.padding(.all,20).background(Color.textFieldColor).clipShape(Circle()).shadow(color: .white, radius: 0.5, x: 0, y: 0)
                if item?.showNotifection ?? false {
                    HStack{
                        Text("\(item?.unReadMessage ?? 0)" ).font(Font.mulishMedium(size: 10)).foregroundColor(Color.white)
                    }.frame(width: 20,height: 20).background(Color.appGreen).clipShape(.circle).padding(.leading,40).padding(.bottom,50)
                }
                
            }
            
            VStack(alignment: .leading,spacing: 3){
                Text(item?.name ?? "").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top,10)
                Text(item?.lastMessage ?? "").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray)
                
            }.padding(.leading,5).padding(.bottom)
            
            Spacer()
            if !(item?.joined ?? false)  {
                HStack{
                    Text("+").font(Font.mulishMedium(size: 25)).foregroundColor(Color.white).padding(.bottom,4)
                    
                }.frame(width: 40,height: 40).background(Color.appGreen).clipShape(.circle)
            }
//            Text("Yesterday").font(Font.mulishMedium(size: 14)).foregroundColor(Color.textColorGray).padding(.bottom,20)
        }.background(Color.white)
    }
}

#Preview {
    GroupsListView()
}
