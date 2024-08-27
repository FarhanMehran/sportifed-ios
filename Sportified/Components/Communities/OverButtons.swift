//
//  OverButtons.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI

struct OverButtons: View {
    var title = ""
    var showIcon = false
    var body: some View {
        Button {
            
            
        } label: {
            ZStack{
                Text(title)
                    .foregroundColor(Color.textColorGray)
                    .cornerRadius(8)
                    .font(.mulishRegular(size: 13.0))
                if showIcon {
                    HStack{
                        Spacer()
                        Image("ic_Arrw").padding(.trailing,10)
                    }
                }
            } .frame(width: 115,height: 45).overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.appGreen, lineWidth: 1.5))
                .frame(width: 100,height: 45)
        }
    }
}

#Preview {
    OverButtons()
}
