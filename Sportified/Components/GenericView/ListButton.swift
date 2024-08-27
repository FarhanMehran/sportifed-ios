//
//  ListButton.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct ListButton: View {
    var title: String = "tariq"
    var bgColor = Color.appGreen
    var foregroundColor = Color.white
    
    let callBack: (() -> Void)
    var body: some View {
        VStack{
            Button {
                callBack()
            } label: {
               
                Text(title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal,3)
                    .frame(height: 28)
                    .foregroundColor(foregroundColor)
                    .background(bgColor)
                    .cornerRadius(6)
                    .font(.mulishRegular(size: 12.0))
            }

        }
    }
}
#Preview {
    
    ListButton2(callBack: {})
}

struct ListButton2: View {
    var title: String = "NBA (48 Minutes) "
    var bgColor = Color.appGreen
    var foregroundColor = Color.white
    var cornerRadius:CGFloat = 6
    
    let callBack: (() -> Void)
    var body: some View {
        VStack{
            Text(title)
                
                .padding(.horizontal)
                .frame(height: 28)
                .foregroundColor(foregroundColor)
                .background(bgColor)
                .cornerRadius(14)
                .font(.mulishRegular(size: 12.0))
        }.onTapGesture {
            callBack()
        }

        
    }
}

struct ListButtonWidth: View {
    var title: String
    var bgColor = Color.appGreen
    var foregroundColor = Color.white
    
    let callBack: (() -> Void)
    var body: some View {
        VStack{
            Button {
                callBack()
            } label: {
               
                Text(title)
                    .padding()
                    .padding(.horizontal,5)
                    .frame(height: 28)
                    .frame(width: 120)
                    .foregroundColor(foregroundColor)
                    .background(bgColor)
                    .cornerRadius(6)
                    .font(.mulishMedium(size: 14.0))
            }

        }
    }
}
