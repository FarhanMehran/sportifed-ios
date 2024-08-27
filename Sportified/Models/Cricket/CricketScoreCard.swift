//
//  CricketScoreCard.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 31/07/2024.
//

import Foundation

class CricketScoreCardSummary: Codable {
    var msg: String?
    var data: CricketScoreCardSummaryData?

    init(msg: String?, data: CricketScoreCardSummaryData?) {
        self.msg = msg
        self.data = data
    }
}

// MARK: - DataClass
class CricketScoreCardSummaryData: Codable {
    var inning1: Inning1?
    var inning2: Inning2?
    var totalOvers, currentInning: Int?

    enum CodingKeys: String, CodingKey {
        case inning1, inning2
        case totalOvers = "total_overs"
        case currentInning = "current_inning"
    }

    init(inning1: Inning1?, inning2: Inning2?, totalOvers: Int?, currentInning: Int?) {
        self.inning1 = inning1
        self.inning2 = inning2
        self.totalOvers = totalOvers
        self.currentInning = currentInning
    }
}

// MARK: - Inning1
class Inning1: Codable {
    var team1Score, team1Wickets, team1ID: Int?
    var team1Name, totalOvers: String?
    var players: [Player]?
    var bowlers: [BowlerData]?
    var extras: Extras?
    var fallOfWickets: [String]?

    enum CodingKeys: String, CodingKey {
        case team1Score = "team1_score"
        case team1Wickets = "team1_wickets"
        case team1ID = "team1_id"
        case team1Name = "team1_name"
        case totalOvers = "total_overs"
        case players, bowlers, extras
        case fallOfWickets = "fall_of_wickets"
    }

    init(team1Score: Int?, team1Wickets: Int?, team1ID: Int?, team1Name: String?, totalOvers: String?, players: [Player]?, bowlers: [BowlerData]?, extras: Extras?, fallOfWickets: [String]?) {
        self.team1Score = team1Score
        self.team1Wickets = team1Wickets
        self.team1ID = team1ID
        self.team1Name = team1Name
        self.totalOvers = totalOvers
        self.players = players
        self.bowlers = bowlers
        self.extras = extras
        self.fallOfWickets = fallOfWickets
    }
}

// MARK: - Bowler
class BowlerData: Codable {
    var id: Int?
    var name, overs: String?
    var wicketsTaken, runsConceded, dotBalls, economyRate: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, overs
        case wicketsTaken = "wickets_taken"
        case runsConceded = "runs_conceded"
        case dotBalls = "dot_balls"
        case economyRate = "economy_rate"
    }

    init(id: Int?, name: String?, overs: String?, wicketsTaken: Int?, runsConceded: Int?, dotBalls: Int?, economyRate: Int?) {
        self.id = id
        self.name = name
        self.overs = overs
        self.wicketsTaken = wicketsTaken
        self.runsConceded = runsConceded
        self.dotBalls = dotBalls
        self.economyRate = economyRate
    }
}

// MARK: - Extras
class Extras: Codable {
    var noBalls, wides, legByes, byes: Int?

    enum CodingKeys: String, CodingKey {
        case noBalls = "no_balls"
        case wides
        case legByes = "leg_byes"
        case byes
    }

    init(noBalls: Int?, wides: Int?, legByes: Int?, byes: Int?) {
        self.noBalls = noBalls
        self.wides = wides
        self.legByes = legByes
        self.byes = byes
    }
}

// MARK: - Player
class Player: Codable {
    var id: Int?
    var name: String?
    var ballsFaced, runsScored, sixes, fours: Int?
    var strikeRate: Int?
    var outBy: Int?
    var status: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case ballsFaced = "balls_faced"
        case runsScored = "runs_scored"
        case sixes, fours
        case strikeRate = "strike_rate"
        case outBy = "out_by"
        case status
    }

    init(id: Int?, name: String?, ballsFaced: Int?, runsScored: Int?, sixes: Int?, fours: Int?, strikeRate: Int?, outBy: Int?, status: String?) {
        self.id = id
        self.name = name
        self.ballsFaced = ballsFaced
        self.runsScored = runsScored
        self.sixes = sixes
        self.fours = fours
        self.strikeRate = strikeRate
        self.outBy = outBy
        self.status = status
    }
}

// MARK: - Inning2
class Inning2: Codable {
    var team2Score, team2Wickets, team2ID: Int?
    var team2Name, totalOvers: String?
    var players: [Player]?
    var bowlers: [BowlerData]?
    var extras: Extras?
    var fallOfWickets: [String]?

    enum CodingKeys: String, CodingKey {
        case team2Score = "team2_score"
        case team2Wickets = "team2_wickets"
        case team2ID = "team2_id"
        case team2Name = "team2_name"
        case totalOvers = "total_overs"
        case players, bowlers, extras
        case fallOfWickets = "fall_of_wickets"
    }

    init(team2Score: Int?, team2Wickets: Int?, team2ID: Int?, team2Name: String?, totalOvers: String?, players: [Player]?, bowlers: [BowlerData]?, extras: Extras?, fallOfWickets: [String]?) {
        self.team2Score = team2Score
        self.team2Wickets = team2Wickets
        self.team2ID = team2ID
        self.team2Name = team2Name
        self.totalOvers = totalOvers
        self.players = players
        self.bowlers = bowlers
        self.extras = extras
        self.fallOfWickets = fallOfWickets
    }
}
