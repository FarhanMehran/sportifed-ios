//
//  OnboardingView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack{
            VStack{
                
                Image.img_Location.resizable().frame(height: 480)
                
                Spacer()
            }
            VStack{
                Spacer()
                ZStack{
                    Image(viewModel.selectedIndex == 0 ? .imgOnbording1 : .imgOnbording2).resizable().frame(height: 485)
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text(viewModel.textHeding).font(Font.mulishBold(size: 28)).foregroundColor(viewModel.selectedIndex == 0 ? Color.black : Color.white)
                                Text(viewModel.textDescription).font(Font.mulishMedium(size: 15)).foregroundColor(viewModel.selectedIndex == 0 ? Color.textColorGray : .white.opacity(0.8)).padding(.top,8)
                                HStack{
                                    ForEach(0..<2,id: \.self){ index in
                                        Color(viewModel.selectedIndex == index ? .appGreen : .white).frame(width: 50,height: 5).cornerRadius(5)
                                    }
                                }.padding(.top,60)
                                HStack{
                                   
                                    Spacer()
                                    ZStack{
                                        BlurView(style: .dark)
                                            .frame(width: 100,height:65).opacity(0.4)
                                        Image.ic_arrow.resizable().frame(width: 40,height: 40)
                                    }.clipShape(Circle()).shadow(color: .white, radius: 0.5, x: 0, y: 0)
                                }.padding(.top,150).padding(.leading).onTapGesture {
                                    viewModel.btnClick()
                                    
                                }
                                
                            }
                            Spacer()
                            
                        }.padding(.horizontal)
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {

    }

}
