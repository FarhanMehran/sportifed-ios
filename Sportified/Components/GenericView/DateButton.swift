//
//  DateButton.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI

struct DateButton: View {
    var title = ""
    var time = ""
    var image = Image.ic_Calander
    var body: some View {
        VStack(alignment: .leading){
            Text(title).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
            HStack {
                Text(time).font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColorGray)
                Spacer()
                image
                
               
            }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10)
        }
    }
}

#Preview {
    DateButton()
}






