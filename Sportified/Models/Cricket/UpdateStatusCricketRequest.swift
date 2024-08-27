//
//  UpdateStatusCricketRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 26/07/2024.
//

import Foundation

struct UpdateStatusCricketRequest: Codable {
    var toss_winner_id: Int?
    var toss_decision: String?
    var match_id: Int?
    var total_overs: Int?
    var match_started:Bool?
    var innings:Bool?
    var match_completed:Bool?
    var bowling_team_id:  Int?
    var batting_team_id: Int?
}


struct UpdateCricketScorecardRequest: Codable {
    var match_id:Int?
    var action:String?
    var player_id:Int?
    var off_strike_id:Int?
    var team_id:Int?
    var extra_type:String?
    var wicket:String?
    var runs:Int?
    var bowler_id:Int?
    var fielder:Int?
    var out_id:Int?
    var innings:Bool?
    var match_completed:Bool?
}

struct UndoReq: Codable {
    var match_id:Int?
}

struct FootBallRequest: Codable {
    var started:Bool?
    var match_id:Int?
    var extra_time:Bool?
    var penalty_shootout:Bool?
    var first_half:Bool?
    var second_half:Bool?
    var action:String?
    var player_id:Int?
    var team_id:Int?
    var minute:Int?
    var goal_type:String?
    var card_type:String?
    var total_time:Int?
}

