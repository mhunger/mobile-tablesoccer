//
//  Match.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 17/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import Foundation

class Match: NSObject {
    private var currentScore = Dictionary<Game.teamId, Int>()
    
    private var winningScore = 7
    
    private var maxGoals = 10
    
    private var finished = false
    
    private var winner: Game.teamId?
    
    override var description: String {
        return "CurrentScore: [\(currentScore)], winner: [\(winner)]"
    }
    
    init(winningScore: Int, maxGoals: Int) {
        super.init()
        
        self.winningScore = winningScore
        self.maxGoals = maxGoals
        
        currentScore[Game.teamId.team1] = 0
        currentScore[Game.teamId.team2] = 0
    }
    
    func getScoreForTeam(team: Game.teamId) -> Int {
        return currentScore[team]!
    }
    
    func increaseScore(scorer: Game.teamId, opponent: Game.teamId) {
        var tempScore: Int = currentScore[scorer]!
        let tempOpponentScore: Int = currentScore[opponent]!
        
        tempScore = (tempScore + 1)
        currentScore[scorer] = tempScore
        
        if(((tempScore >= winningScore)
            && (tempOpponentScore < (tempScore - 1)))
            || tempScore == maxGoals) {
            finish(scorer)
        }
        
        print("Current match score: \(currentScore)")
    }
    
    func finish(winner: Game.teamId) {
        finished = true
        self.winner = winner
    }
    
    func isFinished() -> Bool {
        return finished
    }
    
    func getWinner() -> Game.teamId {
        return winner!
    }
}