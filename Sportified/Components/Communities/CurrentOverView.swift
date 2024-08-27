//
//  CurrentOverView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI

struct CurrentOverView: View {
    var buttonTitle = ""
    var image = "ic_Palyer"
    var score = ""
    var body: some View {
        HStack{
            VStack{
                CurrentOverButton(buttonTitle: buttonTitle,image: image,score: score)
                CurrentOverButton(buttonTitle: buttonTitle,image: image,score: score)
            }
        }
    }
}

#Preview {
    CurrentOverView()
}
struct CurrentOverButton: View {
    var buttonTitle = ""
    var image = ""
    var score = ""
    var body: some View {
       
        HStack(spacing: 20){
            Image(image).padding(.top,2)
            VStack(spacing: 10){
                Button {
                    
                    
                } label: {
                    Text(buttonTitle).frame(maxWidth: .infinity).frame(height: 45)
                        .foregroundColor(Color.textColorGray)
                        .cornerRadius(8)
                        .font(.mulishRegular(size: 13.0))
                        .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.appGreen, lineWidth: 1.5))
                        .frame(width: 100,height: 45)
                }
                Text(score) .font(.mulishRegular(size: 13.0)).foregroundColor(Color.textColorGray)
            }
        }
    }
}
