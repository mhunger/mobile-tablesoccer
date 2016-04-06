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
    
    private var currentScore = [teamId:Int]()

    enum teamId {
        case team1
        case team2
    }
    
    func startGame() {
        started = true
        currentScore[teamId.team1] = 0
        currentScore[teamId.team2] = 0
    }
    
    func stopGame() {
        started = false
    }
    
    func isStarted() -> Bool {
        return started
    }
    
    func getTeamScore(team: teamId) -> Int{
        return currentScore[team]!
    }
    
    func increaseScore(team: teamId) {
        var tempScore: Int = currentScore[team]!;
        tempScore = (tempScore + 1)
        currentScore[team] = tempScore
    }
}