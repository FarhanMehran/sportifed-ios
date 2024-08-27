//
//  HomeView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI
import SwiftUIPullToRefresh
struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        
        ZStack{
            RefreshableScrollView(showsIndicators: false, onRefresh: { done in
                
                viewModel.getSportsNearby(limit: 20)
                viewModel.showActivityIndicator = true
                done()
            }) {
                
                VStack{
                    // appbar
                    HomeAppBar { image in
                        
                        viewModel.fullImage = image
                        viewModel.showProfile.toggle()
                      
                    }
                    //Slider
                    ImageSliderView(showSliderIndecator: true)
                    
                    HStack{
                        
                        Text(StringConstants.nearbyGames).font(Font.mulishMedium(size: 20)).foregroundColor(Color.textColor)
                        Spacer()
                        
                        Text(StringConstants.viewAll).font(Font.mulishMedium(size: 18)).foregroundColor(Color.appGreen).onTapGesture {
                            NotificationCenter.default.post(name: .selectedTab, object: nil)
                        }
                        
                    }.padding(.top,10).padding(.horizontal)
                    
                    LazyVStack(spacing: 20){
                        ForEach(viewModel.nearbyMatchesList.indices, id: \.self){ index in
                            let item = viewModel.nearbyMatchesList[index]
                        
                            
                            NearbyGamesListView (model: item, callBack: {
                                viewModel.coordinator?.loadHomeDetailView(nearbyMatchesitem: item,
                                                                          callBack: {item in
                                    viewModel.updateDataWhileUpdateMatch(item: item)
                                })
                            }).onAppear{
                                
                                if index == viewModel.nearbyMatchesList.count-5 {
                                    viewModel.pagination()
                                }
                            }
                            
                            if index == 4{
                                FindCommunitiesView().onTapGesture {
                                    NotificationCenter.default.post(name: .selectedTab, object: nil)
                                }
                            }
                        }
                    
                    }.padding(.horizontal)
                    if UserDefaultsManager.shared.userProfileData?.role != UserType.user.rawValue {
                        NearbyGamesScecondListView(callBack: {
                            viewModel.coordinator?.loadCreatGame(callBackUpdateData: { item in
                                viewModel.nearbyMatchesList.insert(item, at: 0)
                                BaseData.shared.matchesList.insert(item, at: 0)
                                BaseData.shared.temmatchesList.insert(item, at: 0)
                            })
                        }).padding(.horizontal).padding(.top)
                        NearbyGamesScecondListView(title: "Organize Tournament") {
                            viewModel.coordinator?.loadCreatTournament()
                        }.padding(.horizontal).padding(.top)
                    }
                }
               
            }
            
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
            
            if viewModel.showProfile{
                FullScreenImageView(image:viewModel.fullImage ,isShow: $viewModel.showProfile)
                 
            }
           
        }.edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}


