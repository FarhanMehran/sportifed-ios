//
//  CustomDivider.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct CustomDivider: View {
    var height:CGFloat = 0.5
    var body: some View {
        Color.appGrayColor.frame(width: .infinity,height: height)
    }
}

#Preview {
    CustomDivider()
}
