//
//  FilterTabbarView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct FilterTabbarView: View {
    var filterCallBack:(()->Void)?
    var sortCallBack:(()->Void)?
    var body: some View {
        VStack{
            HStack{
                FilterButton(text: StringConstants.filter, callBack: filterCallBack)
                Color.appGrayColor.frame(width: 1,height: 40)
                FilterButton(image: .ic_Sort,text: StringConstants.sort ,callBack: sortCallBack)
            }
            CustomDivider()
        }.frame(height: 35)
    }
}

#Preview {
    FilterTabbarView()
}

struct FilterButton: View {
    var image =   Image.ic_Filter
    var text = "title"
    var callBack: (()->Void)?
    var body: some View {
        Button(action: {
            callBack?()
        }, label: {
            HStack(spacing: 15){
                image
                Text(text).font(Font.mulishSemiBold(size: 18)).foregroundColor(Color.textColor)
            }.frame(maxWidth: .infinity,maxHeight: 50)
        })
       
    }
}
