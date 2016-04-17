//
//  Game.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 06/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import Foundation

class Game {
    private var started: Bool = false
    
    private var finished: Bool = false
    
    private var currentScore = [teamId:Int]()
    private var matches = [teamId:Int]()

    private var maxGoals: Int = 10
    
    private var winningScore: Int = 7
    
    private var maxMatches: Int = 2
    
    private var teams = [teamId:Team]()
    
    enum teamId {
        case team1
        case team2
    }
    
    init () {
        teams[teamId.team1] = Team()
        teams[teamId.team2] = Team()
    }
    
    func addPlayer(team:teamId, player: Player) {
        teams[team]?.addPlayer(player)
    }
    
    func startGame() {
        started = true
        matches[teamId.team1] = 0
        matches[teamId.team2] = 0
        
        startMatch()
    }
    
    func stopGame() {
        started = false
    }
    
    func startMatch() {
        currentScore[teamId.team1] = 0
        currentScore[teamId.team2] = 0
    }
    
    func isStarted() -> Bool {
        return started
    }
    
    func getTeamScore(team: teamId) -> Int{
        return currentScore[team]!
    }
    
    func getTeamMatches() -> [teamId:Int]{
        return matches
    }
    
    func increaseScore(scorer: teamId, opponent: teamId) {
        var tempScore: Int = currentScore[scorer]!
        var tempOpponentScore: Int = currentScore[opponent]!
        
        tempScore = (tempScore + 1)
        currentScore[scorer] = tempScore
        
        if(((tempScore >= winningScore)
            && (tempOpponentScore < (tempScore - 1)))
                || tempScore == maxGoals) {
            finishMatch(scorer)
        }
    }
    
    func finishMatch(team: teamId) {
        var matchesTemp = matches[team]! + 1
        print("matchesTemp " + "\(matchesTemp)")
        
        matches[team] = matchesTemp
        
        if(matchesTemp >= maxMatches) {
            finishGame()
        } else {
            startMatch()
        }
    }
    
    func finishGame(){
        finished = true
    }
}