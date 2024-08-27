//
//  SportsEndpoints.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/05/2024.
//

import Foundation

enum SportsEndpoints: NetworkRequtable {
    
    case postmatchWithoutTournament(request: MatchWithoutTournamentRequest)
    case PUTmatch(request: MatchWithoutTournamentRequest)
    case postTournament(request: PostTournamentRequest)
    case joinPublicMatch(request: joinPublicMatchRequest)
    case getAllTournaments(sportFilterRequest: SportFilterRequest)
    case getSportsNearby(request: [String : String])
    case saveScorecard(request: joinPublicMatchRequest)
    case getAllmatch
    case getScoreCard(matchID: SportFilterRequest)
   
    var url: String {
        let baseUrl = NetworkConfiguration.shared.getBaseURL()
        switch self {
        case .postmatchWithoutTournament:
            return baseUrl.appending("sports/match/")
        case .PUTmatch:
            return baseUrl.appending("sports/match/")
        case .postTournament:
            return baseUrl.appending("sports/tournament/")
        case .getAllTournaments:
            return baseUrl.appending("sports/tournament/")
        case .joinPublicMatch:
            return baseUrl.appending("sports/join_match/")
        case .getSportsNearby:
            return baseUrl.appending("sports/nearby/")
        case .getAllmatch:
            return baseUrl.appending("sports/match/")
        case .getScoreCard:
            return baseUrl.appending("sports/save_scorecard/")
        case .saveScorecard:
            return baseUrl.appending("sports/save_scorecard/")
        }
    }
   
    var queryItems: [String: String]? {
        switch self {
        case .postmatchWithoutTournament(_), .PUTmatch(_), .postTournament , .joinPublicMatch, .getSportsNearby, .getAllmatch, .saveScorecard:
            return [:]
        case .getScoreCard(let request):
            return request.makeRequestParam()
        case .getAllTournaments(let request):
            return request.makeRequestParam()
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .postmatchWithoutTournament , .postTournament, .joinPublicMatch, .getSportsNearby, .saveScorecard:
            return .POST
            
        case .getAllTournaments, .getAllmatch, .getScoreCard:
            return .GET
        case .PUTmatch:
            return .PUT
        }
    }
    
    var body: Data? {
        switch self {
        case .postmatchWithoutTournament(let MatchWithoutTournamentRequest):
            return MatchWithoutTournamentRequest.encode()
        case .PUTmatch(let MatchWithoutTournamentRequest):
            return MatchWithoutTournamentRequest.encode()
        case .postTournament(let PostTournamentRequest):
            return PostTournamentRequest.encode()
        case .joinPublicMatch(let AuthRequest):
            return AuthRequest.encode()
        case .getSportsNearby(let NearbySportsRequest):
            return NearbySportsRequest.encode()
        case .saveScorecard(let SaveScorecard):
            return SaveScorecard.encode()
        case .getAllTournaments, .getAllmatch, .getScoreCard :
            return nil
        }
  
    }
    
}


