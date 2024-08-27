//
//  GroupView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct GroupView: View {
    
    var body: some View {
        
        VStack{
            
            HomeAppBar(bgColor: .appGreen,height:100,foregroundColor: .white,image: .ic_BellWight,imageArrow: .ic_ArrowDownWight)
            
            FilterTabbarView()
            
            VStack{
                CreateNewGroupButton().padding(.top)
                ScrollView(showsIndicators: false){
                    ForEach(0..<3,id: \.self){index in
                        GroupsListView()
                    }
                }
            }.padding(.horizontal)
            
            
            Spacer()
        }.edgesIgnoringSafeArea(.top)
    }
    
}

#Preview {
    GroupView()
}
