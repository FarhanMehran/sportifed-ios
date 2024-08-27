//
//  CustomBarView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/07/2024.
//

import SwiftUI

struct CustomBarView: View {
   @State var value:Int = 50
    var body: some View {
        VStack(alignment: .leading,spacing: 5){
            Text("\(value) %").font(.mulishBold(size: 20)).foregroundColor(.appGreen)
            ZStack(alignment: .trailing){
                
                
                if value != 0{
                    ZStack{
                        
                    }.frame(width: CGFloat(value)/2+CGFloat(value),height: 10).background(Color.appGreen).animation(.spring())
                }
                ZStack{
                    
                }.frame(width: 150,height: 10).overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.appGrayColor, lineWidth: 1))
            }.cornerRadius(10)
        }
    }
}

#Preview {
    Statistics()
}


struct CustomBarViewleading: View {
    @State var value:Int = 60
    var body: some View {
        VStack(alignment: .trailing,spacing: 5){
            Text("\(value) %").font(.mulishBold(size: 20)).foregroundColor(.textColorGray)
            ZStack(alignment: .leading){
                
                
                if value != 0{
                    ZStack{
                        
                    }.frame(width: CGFloat(value)/2+CGFloat(value),height: 10).background(Color.gray.opacity(0.7)).animation(.spring())
                }
                ZStack{
                    
                }.frame(width: 150,height: 10).overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1))
            }.cornerRadius(10)
        }
    }
}

struct Statistics: View {
   
    var body: some View {
        
        ZStack{
            Text("Possessions %").font(.mulishMedium(size: 13)).foregroundColor(.textColor).offset(y:-5)
            HStack{
                
                CustomBarView()
                CustomBarViewleading()
            }
        }
    }
}
