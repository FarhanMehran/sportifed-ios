//
//  CheckButton.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import SwiftUI

struct CheckButton: View {
    
    @State var check = false
    
    var body: some View {
        
        ZStack{
            Color(check ? .appGreen : .clear).frame(width: check ? 15.8 : 14,height: check ? 15.8 : 14).overlay(RoundedRectangle(cornerRadius: 0, style: .continuous).stroke(Color.textColorGray, lineWidth: check ? 0 : 1.5))
            if check{
                Image.ic_Tick.resizable().frame(width: 8,height: 7)
            }
        }.onTapGesture {
            check.toggle()
        }
    }
}

#Preview {
    CheckButton()
}
