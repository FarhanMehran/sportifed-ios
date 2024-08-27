//
//  CircketServices.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 26/07/2024.
//

import Foundation

protocol CircketServiceable {
    


    func updateStatusCricket<T: Codable>(_ type: T.Type, requset: UpdateStatusCricketRequest) -> CommonResponse<T>
    func updateCricketScorecard<T: Codable>(_ type: T.Type, requset: UpdateCricketScorecardRequest) -> CommonResponse<T>
    func updateStatusFootBall<T: Codable>(_ type: T.Type, requset: FootBallRequest) -> CommonResponse<T>
    func updateFootBallScorecard<T: Codable>(_ type: T.Type, requset: FootBallRequest) -> CommonResponse<T>
    func undoCricketAction<T: Codable>(_ type: T.Type, requset: UndoReq) -> CommonResponse<T>
    func getCricketScorecard<T: Codable>(_ type: T.Type, requset: SportFilterRequest) -> CommonResponse<T>
    func getFootballScore<T: Codable>(_ type: T.Type, requset: SportFilterRequest) -> CommonResponse<T>
    
}

public class CircketServices: CircketServiceable {

    
    
    var networkRequest: Requestable
    
    public init(networkRequest: Requestable = NativeRequestable()) {
        self.networkRequest = networkRequest
    }
    
    func updateStatusCricket<T>(_ type: T.Type, requset: UpdateStatusCricketRequest) -> CommonResponse<T> where T : Decodable, T : Encodable {
        let endpoint = CircketEndpoint.updateStatusCricket(request: requset)
        return self.networkRequest.request(endpoint)
    }
    
    func updateCricketScorecard<T>(_ type: T.Type, requset: UpdateCricketScorecardRequest) -> CommonResponse<T> where T : Decodable, T : Encodable {
        let endpoint = CircketEndpoint.updateCricketScorecard(request: requset)
        return self.networkRequest.request(endpoint)
    }
    
    func updateStatusFootBall<T>(_ type: T.Type, requset: FootBallRequest) -> CommonResponse<T> where T : Decodable, T : Encodable {
        let endpoint = CircketEndpoint.updateStatusFootBall(request: requset)
        return self.networkRequest.request(endpoint)
    }
    
    func updateFootBallScorecard<T>(_ type: T.Type, requset: FootBallRequest) -> CommonResponse<T> where T : Decodable, T : Encodable {
        let endpoint = CircketEndpoint.updateFootBallScorecard(request: requset)
        return self.networkRequest.request(endpoint)
    }
    
    func undoCricketAction<T>(_ type: T.Type, requset: UndoReq) -> CommonResponse<T> where T : Decodable, T : Encodable {
        let endpoint = CircketEndpoint.undoCricketAction(request: requset)
        return self.networkRequest.request(endpoint)
    }
    
    func getCricketScorecard<T>(_ type: T.Type, requset: SportFilterRequest) -> CommonResponse<T> where T : Decodable, T : Encodable {
        let endpoint = CircketEndpoint.getCricketScorecard(prem: requset)
        return self.networkRequest.request(endpoint)
    }
    
    func getFootballScore<T>(_ type: T.Type, requset: SportFilterRequest) -> CommonResponse<T> where T : Decodable, T : Encodable {
        let endpoint = CircketEndpoint.getFootballScore(prem: requset)
        return self.networkRequest.request(endpoint)
    }
    
    
}
