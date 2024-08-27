//
//  ImageSliderView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct ImageSliderView: View {
    var currentIndex = 1
    var showSliderIndecator = false
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image.img_Slider
                    
                }
                
            }
            if showSliderIndecator {
                VStack{
                Spacer()
                HStack{
                    ForEach(0..<4,id: \.self){index in
                        if currentIndex != index{
                            Color.white.opacity(0.7)
                                .frame(width: 10, height: 10)
                                .cornerRadius(10)
                        }else{
                            Color.lightGreenColor
                                .frame(width: 25, height: 10)
                                .cornerRadius(10)
                        }
                    }
                }.padding(.trailing,40).padding(.bottom)
            }
        }
            HStack{
                VStack(alignment:.leading,spacing: 5){
                    Text("Up to").font(Font.mulishMedium(size: 12)).foregroundColor(.white)
                    Text("10% OFF*").font(Font.mulishBold(size: 32)).foregroundColor(.white)
                    Text("Conquer the game!").font(Font.mulishMedium(size: 16)).foregroundColor(.white).padding(.top,5)
                }.padding(.leading)
                Spacer()
            }
        }.frame(maxWidth: .infinity,maxHeight: 204).background(Color.appGreen)
    }
}

#Preview {
    ImageSliderView()
}
