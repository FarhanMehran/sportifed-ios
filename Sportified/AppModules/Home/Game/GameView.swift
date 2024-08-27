//
//  GameView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack{
            VStack{
                HomeAppBar(bgColor: .appGreen,height:90,foregroundColor: .white,image: .ic_BellWight,imageArrow: .ic_ArrowDownWight) { image in
                    viewModel.fullImage = image
                    viewModel.showProfile.toggle()
                }
                
                FilterTabbarView(filterCallBack: {
                    viewModel.sort =  false
                },sortCallBack: {
                    viewModel.sort =  true
                })
                
                ScrollView(showsIndicators: false){
                    VStack(spacing: 20){
                        ForEach(0..<BaseData.shared.temmatchesList.count, id: \.self){ index in
                            let item = BaseData.shared.temmatchesList[index]
                            if index == 2 {
                                ImageSliderView().cornerRadius(20)
                            }
                            NearbyGamesListView (model: item, callBack: {
                                viewModel.coordinator?.loadHomeDetailView(nearbyMatchesitem: item,callBack: {_ in})
                            })                    }
                    }.padding(.horizontal).padding(.top)
                }
                Spacer()
               
            }
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
            if viewModel.showProfile{
                withAnimation{
                    FullScreenImageView(image:viewModel.fullImage ,isShow: $viewModel.showProfile)
                }
            }
        }.edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    GameView(viewModel: GameViewModel())
}
