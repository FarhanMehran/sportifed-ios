//
//  ChatViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import Foundation
class ChatViewModel: BaseViewModel,WebSocketManagerDelegate {
    
    var coordinator: HomeCoordinator?
    
    @Published var txtMassage: String = ""
    @Published var getChatData: GetChatData?
    @Published var chatList: [ChatResult]?
    @Published var sms: [String]? = ["tar"]
    @Published var chatListDic: [(String, [ChatResult])]?
    var item:GetlCommunityResponce?
    var isSender = false
    var isFirst = true
    var callBack:((String)->Void)?
    func sendMassage() {
        if txtMassage.isEmpty{
            return
        }
        if let item = item{
            isSender = true
            let model = SendChatModel(chat_id: item.id,message: txtMassage)
            let sender = Sender(id: 0, fullName: UserDefaultsManager.shared.userProfileData?.fullName ?? "", role: "", img: "",isSend: true)
            let chat = Chat(id: 0, name: "", userOne: User(), userTwo: User(), community: Community(id: 0, members: []))
            let chatdata = ChatResult(id: 0, sender: sender, message: txtMassage, chat: chat, createdAt: Utility.getCurrentDate())
            
            chatList?.insert(chatdata, at: 0)
            let sms = txtMassage
            chatListDic = makeDataAccordingToDates(chatList: chatList ?? [])
            txtMassage = ""
            chatService.sendMassag(BaseResponce.self, requset: model)
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
                    weakSelf.validationText = response.msg ?? ""
                    weakSelf.callBack?(sms)
                    //weakSelf.getChat()
                }
                .store(in: &cancellableSet)
        }
    }
    
    func getChat() {
       
        showActivityIndicator =  isFirst
        if let item = item{
            let model = SportFilterRequest(chat_id: item.id)
            chatService.getCommuntyChat(GetChatData.self, requset: model)
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
                    weakSelf.getChatData = response
                    weakSelf.chatList = response.results ?? []
                    weakSelf.chatListDic = weakSelf.makeDataAccordingToDates(chatList: response.results ?? [])
                    weakSelf.isFirst = false
                }
                .store(in: &cancellableSet)
        }
    }
    
    func didReceiveSocketData(_ data: SocketModel) {
        print("tariq: ", data.message ?? "",data.time ?? "",data.sender ?? "")
        self.getChat()
    }
    
   
    
    func makeDataAccordingToDates(chatList: [ChatResult]) -> [(String, [ChatResult])] {
        var dateDictionary: [String: [ChatResult]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
      
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "EEE, dd, MMMM"
        displayFormatter.locale = Locale(identifier: "en_US_POSIX")
        displayFormatter.timeZone = TimeZone.current
        let today = Date()
        let calendar = Calendar.current
        for chat in chatList {
            if let dateStr = chat.createdAt?.prefix(10),
               let date = dateFormatter.date(from: String(dateStr)) {
                let daysDifference = calendar.dateComponents([.day], from: date, to: today).day ?? 0
                var dateString: String
                
                switch daysDifference {
                case 0:
                    dateString = "Today"
                case 1:
                    dateString = "Yesterday"
                default:
                    dateString = displayFormatter.string(from: date)
                }
                if dateDictionary[dateString] != nil {
                    dateDictionary[dateString]?.append(chat)
                } else {
                    dateDictionary[dateString] = [chat]
                }}
        }
        // Sort the dates in descending order
        let sortedDateDictionary = dateDictionary.sorted { (lhs, rhs) in
            if lhs.key == "Today" {
                return true
            } else if rhs.key == "Today" {
                return false
            } else if lhs.key == "Yesterday" {
                return true
            } else if rhs.key == "Yesterday" {
                return false
            } else {
                // Compare custom dates
                guard let lhsDate = displayFormatter.date(from: lhs.key),
                      let rhsDate = displayFormatter.date(from: rhs.key) else {
                    return false
                }
                return lhsDate > rhsDate
            } }
        return sortedDateDictionary
    }


}
