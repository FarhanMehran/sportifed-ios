//
//  CreateNewGroupButton.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct CreateNewGroupButton: View {
    var title = StringConstants.organizeGame
    var callBack: (()-> Void)?
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                Text(title).font(Font.mulishBold(size: 18)).foregroundColor(.textColor)
                Spacer()
                Text(StringConstants.create).frame(maxWidth: 100).frame(height: 35)
                    .foregroundColor(Color.textColor)
                    .cornerRadius(8)
                    .font(.mulishSemiBold(size: 16.0))
                    .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.gray, lineWidth:1))
                   
            }
            
        }.padding(.horizontal).padding(.vertical,20)
            .frame(maxWidth: .infinity).background(Color.white).overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.appGrayColor, lineWidth: 1)
            ) .onTapGesture {
                callBack?()
            }
    }
}
  

#Preview {
    CreateNewGroupButton()
}
