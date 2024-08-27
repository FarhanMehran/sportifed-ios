//
//  DashLineView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import SwiftUI

struct DashLineView: View {
    var text = StringConstants.orSigninwith
    var body: some View {
        HStack{
            Color.textFieldColor.frame(width: 90,height: 1)
            Text(text).font(Font.mulishMedium(size: 15)).foregroundColor(Color.textColor)
                //.foregroundColor(.gray)
            Color.textFieldColor.frame(width: 90,height: 1)
        }
    }
}

#Preview {
    DashLineView()
}
