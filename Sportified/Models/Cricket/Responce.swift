//
//  Responce.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 29/07/2024.
//

import Foundation
// MARK: - CricketScorecardResponce
class CricketScorecardResponce: Codable {
    var msg: String?
    var data: CricketScorecard?

    init(msg: String?, data: CricketScorecard?) {
        self.msg = msg
        self.data = data
    }
}

// MARK: - DataClass
class CricketScorecard: Codable {
    var currentOver, currentBall, team1Score, team2Score: Int?
    var team1Wickets, team2Wickets: Int?
    var striker, nonStriker: Striker?
    var currentPartnership: CurrentPartnership?
    var bowler: Bowler?
    var currentOverDetails: CurrentOverDetails?

    enum CodingKeys: String, CodingKey {
        case currentOver = "current_over"
        case currentBall = "current_ball"
        case team1Score = "team1_score"
        case team2Score = "team2_score"
        case team1Wickets = "team1_wickets"
        case team2Wickets = "team2_wickets"
        case striker
        case nonStriker = "non_striker"
        case currentPartnership = "current_partnership"
        case bowler
        case currentOverDetails = "current_over_details"
    }

    init(currentOver: Int?, currentBall: Int?, team1Score: Int?, team2Score: Int?, team1Wickets: Int?, team2Wickets: Int?, striker: Striker?, nonStriker: Striker?, currentPartnership: CurrentPartnership?, bowler: Bowler?, currentOverDetails: CurrentOverDetails?) {
        self.currentOver = currentOver
        self.currentBall = currentBall
        self.team1Score = team1Score
        self.team2Score = team2Score
        self.team1Wickets = team1Wickets
        self.team2Wickets = team2Wickets
        self.striker = striker
        self.nonStriker = nonStriker
        self.currentPartnership = currentPartnership
        self.bowler = bowler
        self.currentOverDetails = currentOverDetails
    }
}

// MARK: - Bowler
class Bowler: Codable {
    var id: Int?
    var name, overs: String?
    var runsConceded, wickets: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, overs
        case runsConceded = "runs_conceded"
        case wickets
    }

    init(id: Int?, name: String?, overs: String?, runsConceded: Int?, wickets: Int?) {
        self.id = id
        self.name = name
        self.overs = overs
        self.runsConceded = runsConceded
        self.wickets = wickets
    }
}

// MARK: - CurrentOverDetails
class CurrentOverDetails: Codable {
    var balls: [Ball]?
    var runsConceded: Int?

    enum CodingKeys: String, CodingKey {
        case balls
        case runsConceded = "runs_conceded"
    }

    init(balls: [Ball]?, runsConceded: Int?) {
        self.balls = balls
        self.runsConceded = runsConceded
    }
}

// MARK: - Ball
class Ball: Codable {
    var id, runs: Int?
    var wide, noBall, legBye, bye: Bool?

    enum CodingKeys: String, CodingKey {
        case id, runs, wide
        case noBall = "no_ball"
        case legBye = "leg_bye"
        case bye
    }

    init(id: Int?, runs: Int?, wide: Bool?, noBall: Bool?, legBye: Bool?, bye: Bool?) {
        self.id = id
        self.runs = runs
        self.wide = wide
        self.noBall = noBall
        self.legBye = legBye
        self.bye = bye
    }
}

// MARK: - CurrentPartnership
class CurrentPartnership: Codable {
    var runs, balls: Int?

    init(runs: Int?, balls: Int?) {
        self.runs = runs
        self.balls = balls
    }
}

// MARK: - Striker
class Striker: Codable {
    var id: Int?
    var name: String?
    var runs, balls: Int?

    init(id: Int?, name: String?, runs: Int?, balls: Int?) {
        self.id = id
        self.name = name
         self.runs = runs
        self.balls = balls
    }
}
