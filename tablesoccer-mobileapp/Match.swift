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
    
    private var players =
            Dictionary<Game.side,
                Dictionary<Game.position,MatchPlayer>>()
    
    override var description: String {
        return "CurrentScore: [\(currentScore)], winner: [\(winner)]"
    }
    
    init(winningScore: Int, maxGoals: Int) {
        super.init()
        
        self.winningScore = winningScore
        self.maxGoals = maxGoals
        
        currentScore[Game.teamId.team1] = 0
        currentScore[Game.teamId.team2] = 0
        
        players =
            [Game.side.dark:
                [Game.position.defense: MatchPlayer(), Game.position.offense: MatchPlayer()],
            Game.side.light:
                [Game.position.defense: MatchPlayer(), Game.position.offense: MatchPlayer()]
            ];
        
    }
    
    func addPlayer(team: Game.teamId, side: Game.side, position: Game.position, player: MatchPlayer) {
        players[side]![position]! = player
        
    }
    
    func getScoreForTeam(team: Game.teamId) -> Int {
        return currentScore[team]!
    }
    
    func increaseScore(scorer: Game.teamId, side: Game.side, position: Game.position, opponent: Game.teamId) {
        var tempScore: Int = currentScore[scorer]!
        let tempOpponentScore: Int = currentScore[opponent]!
        
        tempScore = (tempScore + 1)
        players[side]![position]!.increaseScore()
        
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