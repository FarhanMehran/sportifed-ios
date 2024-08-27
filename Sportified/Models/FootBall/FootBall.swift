//
//  FootBall.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/08/2024.
//

import Foundation

// MARK: - FoodBall
class FootballScoreCardSummaryModel: Codable {
    var msg: String?
    var data: FootballScoreCardSummaryData?

    init(msg: String?, data: FootballScoreCardSummaryData?) {
        self.msg = msg
        self.data = data
    }
}

// MARK: - DataClass
class FootballScoreCardSummaryData: Codable {
    var matchID: Int?
    var team1, team2: String?
    var team1Score, team2Score: Int?
    var extraTime, penaltyShootout, firstHalf, secondHalf: Bool?
    var goals, cards: [Card]?
    var matchStarted: Bool?
    var matchTime: Int?
    var matchCompleted: Bool?

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case team1, team2
        case team1Score = "team1_score"
        case team2Score = "team2_score"
        case extraTime = "extra_time"
        case penaltyShootout = "penalty_shootout"
        case firstHalf = "first_half"
        case secondHalf = "second_half"
        case goals, cards
        case matchStarted = "match_started"
        case matchTime = "match_time"
        case matchCompleted = "match_completed"
    }

    init(matchID: Int?, team1: String?, team2: String?, team1Score: Int?, team2Score: Int?, extraTime: Bool?, penaltyShootout: Bool?, firstHalf: Bool?, secondHalf: Bool?, goals: [Card]?, cards: [Card]?, matchStarted: Bool?, matchTime: Int?, matchCompleted: Bool?) {
        self.matchID = matchID
        self.team1 = team1
        self.team2 = team2
        self.team1Score = team1Score
        self.team2Score = team2Score
        self.extraTime = extraTime
        self.penaltyShootout = penaltyShootout
        self.firstHalf = firstHalf
        self.secondHalf = secondHalf
        self.goals = goals
        self.cards = cards
        self.matchStarted = matchStarted
        self.matchTime = matchTime
        self.matchCompleted = matchCompleted
    }
}

// MARK: - Card
class Card: Codable {
    var playerID: Int?
    var playerFullName: String?
    var teamID: Int?
    var teamName, time, cardType, goalType: String?

    enum CodingKeys: String, CodingKey {
        case playerID = "player_id"
        case playerFullName = "player__full_name"
        case teamID = "team_id"
        case teamName = "team__name"
        case time
        case cardType = "card_type"
        case goalType = "goal_type"
    }

    init(playerID: Int?, playerFullName: String?, teamID: Int?, teamName: String?, time: String?, cardType: String?, goalType: String?) {
        self.playerID = playerID
        self.playerFullName = playerFullName
        self.teamID = teamID
        self.teamName = teamName
        self.time = time
        self.cardType = cardType
        self.goalType = goalType
    }
}
