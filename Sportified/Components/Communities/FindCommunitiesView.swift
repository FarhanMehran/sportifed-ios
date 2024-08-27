//
//  FindCommunitiesView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI

struct FindCommunitiesView: View {
    var body: some View {
        VStack(spacing: 5){
            Image.ic_FindUsers
            Text(StringConstants.findCommunities).font(Font.mulishMedium(size: 20)).foregroundColor(Color.white)
            Text(StringConstants.findCommunitiesMass).font(Font.mulishMedium(size: 13)).foregroundColor(Color.white).multilineTextAlignment(.center)
        }.padding().frame(maxWidth: .infinity).background(Color.appGreen).cornerRadius(15)
    }
}

#Preview {
    FindCommunitiesView()
}
