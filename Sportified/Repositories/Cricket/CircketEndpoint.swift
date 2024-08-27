//
//  CircketEndpoint.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 26/07/2024.
//

import Foundation

enum CircketEndpoint: NetworkRequtable {
 
    case updateStatusCricket(request: UpdateStatusCricketRequest)
    case updateCricketScorecard(request: UpdateCricketScorecardRequest)
    case updateStatusFootBall(request: FootBallRequest)
    case updateFootBallScorecard(request: FootBallRequest)
    case undoCricketAction(request: UndoReq)
    case getCricketScorecard(prem: SportFilterRequest)
    case getFootballScore(prem: SportFilterRequest)
    var url: String {
        let baseUrl = NetworkConfiguration.shared.getBaseURL()
        switch self {
        case .updateStatusCricket:
            return baseUrl.appending("sports/update_status_cricket/")
        case .updateCricketScorecard:
            return baseUrl.appending("sports/update_cricket_scorecard/")
        case .updateStatusFootBall:
            return baseUrl.appending("sports/update_football_status/")
        case .updateFootBallScorecard:
            return baseUrl.appending("sports/update_football_score/")
        case .undoCricketAction:
            return baseUrl.appending("sports/undo_cricket_action/")
        case .getCricketScorecard:
            return baseUrl.appending("sports/get_cricket_scorecard/")
        case .getFootballScore:
            return baseUrl.appending("sports/get_football_score/")
        }
    }
  
    var queryItems: [String: String]? {
        switch self {
        case  .updateStatusCricket, .updateCricketScorecard, .undoCricketAction, .updateStatusFootBall,.updateFootBallScorecard:
            return [:]
        case .getCricketScorecard(let request):
            return request.makeRequestParam()
        case .getFootballScore(let request):
            return request.makeRequestParam()
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
       
        case  .updateStatusCricket,.updateCricketScorecard, .undoCricketAction,.updateStatusFootBall,.updateFootBallScorecard:
            return .POST
        case .getCricketScorecard,.getFootballScore:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .updateStatusCricket(let UpdateStatusCricketRequest) :
            return UpdateStatusCricketRequest.encode()
        case .updateCricketScorecard(let UpdateCricketScorecardRequest) :
            return UpdateCricketScorecardRequest.encode()
        case .updateStatusFootBall(let FootBallRequest) :
            return FootBallRequest.encode()
        case .updateFootBallScorecard(let FootBallRequest) :
            return FootBallRequest.encode()
        case .undoCricketAction(let UndoReq) :
            return UndoReq.encode()
        case .getCricketScorecard ,.getFootballScore:
            return nil
        }
  
    }
    
}
