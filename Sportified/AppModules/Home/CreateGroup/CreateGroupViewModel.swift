//
//  CreateGroupViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import Foundation
class CreateGroupViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    @Published var getAllUserList: GetAllUserResponce?
    @Published  var tempgetAllUserList: GetAllUserResponce?
    var callBack:((GetAllChatsResponse)->Void) = {_ in}
    @Published  var txtSearch:String = ""{
        didSet{
            searchCommunities()
        }
    }
    @Published var userID:[Int]? = []
    @Published var groupName:String = ""
    
    func searchCommunities(){
        if txtSearch == ""{
            tempgetAllUserList = getAllUserList
        }else{
            tempgetAllUserList?.data =  getAllUserList?.data?.filter({  item in
                return item.name?.lowercased().contains(txtSearch.lowercased()) ?? false
                
            })
            
        }
    }
    
    func btnCreateGroup() {
        if groupName.isEmpty{
            validationText = "Enter Group Name"
            toastType = .warning
        }else if userID == nil || userID!.isEmpty {
            validationText = "select user"
            toastType = .warning
        }else{
            creatGroup()
        }
        
    }
    
    func getAllUser() {
        showActivityIndicator = true
        chatService.getAllUser(GetAllUserResponce.self)
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
                weakSelf.showActivityIndicator = false
                weakSelf.getAllUserList = response
                weakSelf.tempgetAllUserList = response
            }
            .store(in: &cancellableSet)
    }
    
    func creatGroup() {
        showActivityIndicator = true
        let model = CreatGroupRequest(name: groupName, users: userID)
        chatService.creatNewGroup(BaseResponce.self, requset: model)
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
                weakSelf.validationText = response.msg ?? ""
                weakSelf.toastType = .success
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
                if var results = response.results {
                       if let lastItem = results.popLast() {
                           results.insert(lastItem, at: 0)
                           response.results = results  // Assign the modified array back to `response.results`
                       }
                   }
                weakSelf.callBack(response)
                weakSelf.showActivityIndicator = false
                weakSelf.coordinator?.popNavigationView()
            }
            .store(in: &cancellableSet)
    }
    
}
