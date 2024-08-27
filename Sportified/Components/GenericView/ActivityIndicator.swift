//
//  ActivityIndicator.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import SwiftUI

struct ActivityIndicator: View {
    var color = Color.textField.opacity(0.7)
    var colorIndicator = Color.appGreenColor.opacity(0.8)
    var body: some View {
        ZStack {
            GeometryReader { _ in
                VStack(alignment: .center) {
                    Spacer()
                    HStack(alignment: .center) {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: colorIndicator))
                            .scaleEffect(2.2)
                        Spacer()
                    }
                    Spacer()
                }
            }.background(color)
        }.edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ActivityIndicator()
}
