//
//  AccountButton.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct AccountButton: View {
    
    var image = Image.account_Fill
    var title = "title"
    var showSwitchButton = false
    var callBack: (()->Void)?
    var body: some View {
        HStack{
            ZStack{
                
                image
                
            }.frame(width: 50,height: 50).background(Color.textFieldColor).clipShape(Circle()).shadow(color: .white, radius: 0.5, x: 0, y: 0)
            
            Text(title).font(Font.mulishMedium(size: 18)).foregroundColor(Color.accountTextColor).padding(.horizontal)
            if showSwitchButton{
                Spacer()
                Image.ic_SwitchOn
            }
            
        }.padding(.horizontal).background(Color.white.opacity(0.001)).onTapGesture {
            callBack?()
        }
    }
}

#Preview {
    AccountButton()
}
