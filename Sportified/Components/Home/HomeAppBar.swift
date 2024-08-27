//
//  HomeAppBar.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct HomeAppBar: View {
    var bgColor = Color.clear
    var height:CGFloat = 90
    var foregroundColor = Color.textColor
    var image =   Image.ic_bell
    var imageArrow =   Image.ic_arrowDownBlck
    var callBack:((String)-> Void)?
    var body: some View {
        HStack{
          
            
            WebImageView(image: "\(UserDefaultsManager.shared.userProfileData?.img ?? "")")
                .frame(width: 60,height: 60)
                .clipShape(.circle).onTapGesture {
                    callBack?(UserDefaultsManager.shared.userProfileData?.img ?? "")
                }
            Text(StringConstants.loction).font(Font.mulishRegular(size: 16)).foregroundColor(foregroundColor)
            imageArrow
            Spacer()
            image
        }.frame(height: height).padding(.top,25).padding(.horizontal,15).background(bgColor)
        
    }
}

#Preview {
    HomeAppBar()
}

