//
//  Tabview.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct Tabview: View {
    @Binding  var selectedTab: Tab
    
    var body: some View {
        HStack{
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        Button(action: {
                            self.selectedTab = tab
                        }) {
                            VStack{
                                Image(self.selectedTab == tab ? tab.selectedImage : tab.defaultImage).padding(.top,30)
                                Text(tab.title).font(Font.mulishMedium(size: 12))
                                    .foregroundColor(self.selectedTab == tab ? Color.appGreen : Color.textColorGray)
                            }
                            .frame(width: geometry.size.width / CGFloat(Tab.allCases.count), height: 19)
                            .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
        }.frame(height: 80)
    }
}

#Preview {
    Tabview(selectedTab: .constant(.home))
}
