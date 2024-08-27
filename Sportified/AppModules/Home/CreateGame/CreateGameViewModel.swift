//
//  CreateGameViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import Foundation
enum CreateGameType{
    case createGame
    case editGame
}
class CreateGameViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    var routType: CreateGameType = .createGame
    var nearbyMatchesitem: NearbyMatchesList?
    var callBack:((NearbyMatchesList)->Void) = {_ in}
    
    @Published  var favoriteSportsList:[SportsData]?
    @Published  var tournamentList:[NearbyMatchesList]?
    @Published var sport:SportsData?
    @Published var title = ""
    @Published var description = ""
    @Published var venue = "Zayed Cricket Stadium, Abu Dhabi, UAE"
    @Published var gameDate = "\(Utility.changeDateFormatReturnString(date: Date(), format: "YYYY:MM:dd"))"
    
    @Published var gameTime = "\(Utility.changeDateFormatReturnString(date: Date(), format: "HH:mm:ss"))"
    @Published var fee = ""
    @Published var venueLat = "0.6789"
    @Published var venueLong = "25.222"
    @Published var gameAccess:GameAccess = .gameAccessPublic
    @Published var gameType = ""
    @Published var skillRequired = "Beginner"
    @Published var team1Name = ""
    @Published var team2Name = ""
    @Published var playersLimit = "0"
    @Published var byoe:Bool = false
    @Published var tournament:Int? = nil
    @Published var matchId:Int? = nil
    
    @Published var showTournamentList = false
    @Published var regularTogle = false{
        didSet{
            if regularTogle{
                isTournamentMatach = false
            }else{
                
            }
        }
    }
    @Published var isTournamentMatach = false{
        didSet{
            if isTournamentMatach{
                showTournamentList = true
                regularTogle = false
            }
        }
    }
    @Published var showTimePicker = false
    @Published var showDatePicker = false
    @Published var showDropDown = false
    @Published var drowDownType:CreateGameDrowDownType = .sport
    
    func btnCreateGame(){
        if title.isEmpty || description.isEmpty || fee.isEmpty  || team1Name.isEmpty || team2Name.isEmpty{
            validationText = "Enter all fields"
            return
        }
        
        
        //2024-12-10T13:27:14
        //2024-12-10T10:10:10
        let date = "\(gameDate.replacingOccurrences(of: ":", with: "-"))T\(gameTime.trimmingCharacters(in: .whitespaces))".trimmingCharacters(in: .whitespaces)
        if isTournamentMatach {
            if tournament == nil{
                validationText = "UnCheck the Tournament or select any Tournament"
                toastType = .warning
                return
            }
        }
        let request = MatchWithoutTournamentRequest(title: title,
                                            description: description,
                                            venue: venue,
                                            sport: sport?.id,
                                            venueLat: venueLat,
                                            venueLong: venueLong,
                                            gameDateTime: date,
                                            gameAccess: gameAccess.rawValue,
                                            skillRequired: skillRequired, 
                                            playersLimit: playersLimit,
                                            tournament: tournament,
                                            byoe: byoe,
                                            fee: fee,
                                            team1: team1Name,
                                            team2: team2Name,
                                            id: matchId)
        if routType == .createGame{
            postMatch(request: request)
        }else{
            putMatch(request: request)
        }
    }
    
    
    private func putMatch(request: MatchWithoutTournamentRequest){
         showActivityIndicator = true
         sportsServices.putmatchWithoutTournament(PostTournamentResponce.self, request: request)
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
                 weakSelf.nearbyMatchesitem = response.data
                 weakSelf.callBack(weakSelf.nearbyMatchesitem!)
                 weakSelf.showActivityIndicator = false
                 weakSelf.coordinator?.popNavigationView()
             }
         .store(in: &cancellableSet)
     }
    
   private func postMatch(request: MatchWithoutTournamentRequest){
        showActivityIndicator = true
        sportsServices.postmatchWithoutTournament(PostTournamentResponce.self, request: request)
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
            BaseData.shared.matchesList.insert(response.data!, at: 0)
            BaseData.shared.temmatchesList.insert(response.data!, at: 0)
            weakSelf.callBack(response.data!)
            weakSelf.showActivityIndicator = false
            weakSelf.coordinator?.popNavigationView()
        }
        .store(in: &cancellableSet)
    }
    
    func getSports() {
       // showActivityIndicator = true
        authService.getSports(GetSportsResponce.self)
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
                weakSelf.favoriteSportsList = response.data
                weakSelf.sport = weakSelf.favoriteSportsList?[0] ?? SportsData()
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
    
    func getAllTournaments() {
       // showActivityIndicator = true
        sportsServices.getAllTournaments(mo.self, filterRequest: SportFilterRequest())
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
                weakSelf.tournamentList = response.data
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
    
    func changeGameViewAppere(){
        if let data = nearbyMatchesitem {
            matchId = data.id
            title = data.title!
            description = data.description!
           // sport?.name = data.sport
            if let date = ISO8601DateFormatter().date(from: data.gameDateTime!) {
                gameDate = "\(Utility.changeDateFormatReturnString(date: date, format: "YYYY:MM:dd"))"
                gameTime = "\(Utility.changeDateFormatReturnString(date: date, format: "HH:mm:ss"))"
            }
            if data.tournament == nil{
                regularTogle = true
            }else{
                isTournamentMatach = true
            }
            gameAccess = data.gameAccess!
           // gameType = data.gameType?.rawValue!
            skillRequired = data.skillRequired!.rawValue
            team1Name = data.teams?.first?.name ?? ""
            team2Name = data.teams?.last?.name ?? ""
            playersLimit = "\(data.playersLimit ?? 0)"
            byoe = data.byoe!
            fee = data.fee!
        }
    }
}
struct mo:Codable{
    var msg:String?
    var data:[NearbyMatchesList]?
}
