//
//  SportsServices.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/05/2024.
//

import Foundation

protocol SportsServiceable {
    
    func postmatchWithoutTournament<T: Codable>(_ type: T.Type, request: MatchWithoutTournamentRequest) -> CommonResponse<T>
    func putmatchWithoutTournament<T: Codable>(_ type: T.Type, request: MatchWithoutTournamentRequest) -> CommonResponse<T>
    func postTournament<T: Codable>(_ type: T.Type, request: PostTournamentRequest) -> CommonResponse<T>
    func joinPublicMatch<T: Codable>(_ type: T.Type, request: joinPublicMatchRequest) -> CommonResponse<T>
    func getAllTournaments<T: Codable>(_ type: T.Type, filterRequest: SportFilterRequest) -> CommonResponse<T>
    func getSportsNearby<T: Codable>(_ type: T.Type, request: SportFilterRequest) -> CommonResponse<T>
    func getAllmatch<T: Codable>(_ type: T.Type) -> CommonResponse<T>
}

public class SportsServices: SportsServiceable {
    
    var networkRequest: Requestable
    
    public init(networkRequest: Requestable = NativeRequestable()) {
        self.networkRequest = networkRequest
    }
    
    func postmatchWithoutTournament<T: Codable>(_ type: T.Type, request: MatchWithoutTournamentRequest) -> CommonResponse<T> {
        let endpoint = SportsEndpoints.postmatchWithoutTournament(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func putmatchWithoutTournament<T: Codable>(_ type: T.Type, request: MatchWithoutTournamentRequest) -> CommonResponse<T> {
        let endpoint = SportsEndpoints.PUTmatch(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func postTournament<T: Codable>(_ type: T.Type, request: PostTournamentRequest) -> CommonResponse<T> {
        let endpoint = SportsEndpoints.postTournament(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func joinPublicMatch<T: Codable>(_ type: T.Type, request: joinPublicMatchRequest) -> CommonResponse<T> {
        let endpoint = SportsEndpoints.joinPublicMatch(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func getSportsNearby<T: Codable>(_ type: T.Type, request: SportFilterRequest) -> CommonResponse<T> {
        let endpoint = SportsEndpoints.getSportsNearby(request: request.makeRequestParam())
        return self.networkRequest.request(endpoint)
    }
    
    func getAllTournaments<T: Codable>(_ type: T.Type, filterRequest: SportFilterRequest) -> CommonResponse<T> {
        let endpoint = SportsEndpoints.getAllTournaments(sportFilterRequest: filterRequest)
        return self.networkRequest.request(endpoint)
    }
 
    func getAllmatch<T: Codable>(_ type: T.Type) -> CommonResponse<T> {
        let endpoint = SportsEndpoints.getAllmatch
        return self.networkRequest.request(endpoint)
    }
}

