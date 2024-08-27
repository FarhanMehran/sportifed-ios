//
//  DropDownText.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/05/2024.
//

import SwiftUI

struct DropDownText: View {

    var text:String = ""
    var callBack:(()->Void)?
    var body: some View {
        
        Button(action: {
            callBack?()
        }, label: {
            VStack(spacing: 10){
                Text(text).font(Font.mulishBold(size: 18)).foregroundColor(Color.textColor).frame(maxWidth: .infinity,alignment: .leading).onTapGesture {
                    
                }.padding(.horizontal)
                CustomDivider()
            }
        })
    }
}

#Preview {
    CreateGameView(viewModel: CreateGameViewModel())
}
struct DropDownTitle: View {

    var text:String = ""
    var body: some View {
        Text(text).font(Font.mulishBold(size: 22)).padding(.horizontal, 20).padding(.top, 24).padding(.bottom, 16).frame(maxWidth: .infinity, alignment: .center)
    }
}
