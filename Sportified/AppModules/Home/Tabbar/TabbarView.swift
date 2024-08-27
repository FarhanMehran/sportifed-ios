//
//  TabbarView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct TabbarView: View {
    var coordinator: HomeCoordinator?

   
    @State var selectedTab: Tab = .home
    
  
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var gameViewModel: GameViewModel
    @ObservedObject var accountViewModel: AccountViewModel
    @ObservedObject var communitiesViewModel: CommunitiesViewModel

    init(coordinator: HomeCoordinator) {
        self.homeViewModel = HomeViewModel(coordinator: coordinator)
        self.gameViewModel = GameViewModel(coordinator: coordinator)
        self.accountViewModel = AccountViewModel(coordinator: coordinator)
        self.communitiesViewModel = CommunitiesViewModel(coordinator: coordinator)
        WebSocketManager.shared.delegate = communitiesViewModel.self
    }
    var body: some View {
        
        VStack(spacing: 0){
            
            switch selectedTab {
            case .home:
                HomeView(viewModel: homeViewModel)
            case .games:
                GameView(viewModel: gameViewModel)
            case .communities:
                CommunitiesView(viewModel: communitiesViewModel)
            case .account:
                AccountView(viewModel: accountViewModel)
            }
            
            Spacer()
            if  !BaseData.shared.hidebar {
                Tabview(selectedTab: $selectedTab).onReceive(NotificationCenter.default.publisher(for: .selectedTab), perform: { not in
            
                    self.selectedTab = .games
                })
            }
        }.edgesIgnoringSafeArea(.bottom)
        
    }
}

#Preview {
    TabbarView(coordinator:  HomeCoordinator(navigationController: UINavigationController()))
}

extension NSNotification.Name {
    static let selectedTab = Notification.Name("selectedTab")
}

