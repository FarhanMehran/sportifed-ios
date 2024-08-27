//
//  CommunitiesViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import Foundation
class CommunitiesViewModel: BaseViewModel, WebSocketManagerDelegate {
    
    
    
    var coordinator: HomeCoordinator?
    
    @Published  var communitiesList:[GetlCommunityResponce]?
    @Published  var getAllChatsResponse:[GetlCommunityResponce]?
    @Published  var temcommunitiesList:[GetlCommunityResponce]?
    @Published  var txtSearch:String = ""{
        didSet{
            searchCommunities()
        }
    }
    
    init(coordinator: HomeCoordinator? = nil) {
        super.init()
        self.coordinator = coordinator
        self.getCommunities()
        NotificationCenter.default.publisher(for: .myNotification)
               .sink(receiveValue: { _ in
                   self.getCommunities()
               })
               .store(in: &cancellableSet)
    }
    
    func searchCommunities(){
        if txtSearch == ""{
            temcommunitiesList = communitiesList
        }else{
            temcommunitiesList = communitiesList?.filter { item in
                return item.name?.lowercased().contains(txtSearch.lowercased()) ?? false
            }
        }
    }
    
    func getCommunities() {
        showActivityIndicator = true
        chatService.getCommunities([GetlCommunityResponce].self)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    guard let weakSelf = self else { return }
                    weakSelf.validationText = error.msg ?? ""
                    weakSelf.showActivityIndicator = false
                default:
                    break
                }
            } receiveValue: { [weak self]  (response) in
                guard let weakSelf = self else { return }
                weakSelf.communitiesList = response
                weakSelf.temcommunitiesList = response
                weakSelf.showActivityIndicator = false
                weakSelf.getUserChat()
            }
            .store(in: &cancellableSet)
    }
    
    func getUserChat() {
        showActivityIndicator = true
        chatService.getUserChat(GetAllChatsResponse.self)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    guard let weakSelf = self else { return }
                    weakSelf.validationText = error.msg ?? ""
                    weakSelf.showActivityIndicator = false
                default:
                    break
                }
            } receiveValue: { [weak self]  (response) in
                guard let weakSelf = self else { return }
                weakSelf.getAllChatsResponse = response.results ?? []
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
    
    func didReceiveSocketData(_ data: SocketModel) {
        print("tariq: ", data.message ?? "")
        if let results = getAllChatsResponse{
            var list =  results.sorted { $0.id!  == data.chatID ? true : ($1.id!  == data.chatID  ? false : $0.id! < $1.id!) }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.01){
                if !list.isEmpty{
                    list[0].showNotifection = true
                    list[0].unReadMessage += 1
                    list[0].lastMessage = data.message ?? ""
                }
                self.getAllChatsResponse =  list
            }
        }
    }
}
