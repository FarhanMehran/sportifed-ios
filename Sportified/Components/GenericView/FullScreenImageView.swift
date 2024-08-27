//
//  FullScreenImageView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/07/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct FullScreenImageView: View {
    var image:String = ""
    @State var offset = CGSize.zero
    @State var bg:Double = 1
    @Binding var isShow:Bool
    @State private var currentZoom = 0.0
    var body: some View {
        ZStack{
            ZStack{
                
                Color.black.edgesIgnoringSafeArea(.all)
                VStack{
                    WebImage(url: URL(string: "http://3.83.13.164\(image)"))
                    
                    { image in
                        
                        image.scaleEffect(currentZoom > 1 ? currentZoom : 1)
                            .gesture(MagnificationGesture().onChanged({ value in
                                currentZoom = value
                            }).onEnded({ (_) in
                                withAnimation(.spring()){
                                    currentZoom = 1
                                }
                            }).simultaneously(with: TapGesture(count: 2).onEnded({ value in
                                withAnimation {
                                    currentZoom = currentZoom > 1 ? 1 : 4
                                }
                            })))
                        
                        // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
                    } placeholder: {
                        ActivityIndicator(color: .black, colorIndicator: .white)
                    }
                    // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                    .onSuccess { image, data, cacheType in
                        // Success
                        // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                    }
                    .resizable()
                    .frame(maxWidth: UIScreen.main.bounds.width,maxHeight: UIScreen.main.bounds.height/2)
                    .transition(.fade(duration: 0.5))
                }
                
                
                
            }
            .offset(x:offset.width, y:offset.height)
            .opacity(bg)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        
                        let height = UIScreen.main.bounds.height / 2
                        let progress = offset.height / height
                        withAnimation(.default){
                            bg = Double(1 - progress)
                        }
                    }
                    .onEnded({ value in
                        withAnimation(.easeInOut){
                            var translation = value.translation.height
                            if translation < 0{
                                translation = -translation
                            }
                            if translation < 250{
                                offset = .zero
                                bg = 1
                            }else{
                                isShow.toggle()
                            }
                        }
                    })).frame(maxWidth: UIScreen.main.bounds.width,maxHeight: UIScreen.main.bounds.height)
            VStack{
                HStack{
                    Spacer()
                   
                    Button {
                        isShow.toggle()
                    } label: {
                        HStack{
                            Spacer()
                            
                            ZStack{
                                Text("X").font(Font.mulishBold(size: 15)).foregroundColor(Color.red)
                            }.frame(width: 30, height: 30).background(Color.textFieldColor)
                                .clipShape(.circle)
                                .padding(.trailing,20)
                        }
                    }
                }
                Spacer()
            }.padding(.top,100)
        }
        
    }
}

#Preview {
    FullScreenImageView( isShow: .constant(true))
}
