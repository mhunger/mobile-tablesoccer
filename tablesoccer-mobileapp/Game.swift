//
//  Game.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 08/05/16.
//  Copyright © 2016 Michael Hunger. All rights reserved.
//

import Foundation

class Game: NSObject {
    private var finished: Bool = false
    
    private var matches = [teamId:Int]()
    
    private var maxGoals: Int
    
    private var winningScore: Int
    
    private var maxMatches: Int
    
    private var teams = [teamId:Team]()
    
    private var currentMatch: Match?
    
    override  var description: String {
        return "team: \(teams) matches: \(matches)"
    }
    
    enum teamId {
        case team1
        case team2
    }
    
    init (maxGoals: Int, winningScore: Int, maxMatches: Int) {
        self.maxGoals = maxGoals
        self.winningScore = winningScore
        self.maxMatches = maxMatches
        
        super.init()
        
        teams[teamId.team1] = Team()
        teams[teamId.team2] = Team()
        currentMatch = Match(winningScore: winningScore, maxGoals: maxGoals)
    }
    
    func addPlayer(team:teamId, player: Player) {
        teams[team]?.addPlayer(player)
    }
    
    func start() {
        matches[teamId.team1] = 0
        matches[teamId.team2] = 0
        
        startMatch()
    }
    
    func startMatch() {
        currentMatch = Match(winningScore: winningScore, maxGoals: maxGoals)
    }
    
    func getTeamScore(team: teamId) -> Int{
        return currentMatch!.getScoreForTeam(team)
    }
    
    func getTeams() -> [teamId:Team] {
        return teams
    }
    
    func getTeamMatches() -> [teamId:Int]{
        return matches
    }
    
    func setTeams(teams: [teamId:Team]) {
        self.teams = teams
    }
    
    func increaseScore(scorer: teamId, opponent: teamId) {
        currentMatch!.increaseScore(scorer, opponent: opponent)
        
        if(currentMatch!.isFinished()) {
            finishMatch(currentMatch!.getWinner())
        }
    }
    
    func finishMatch(team: teamId) {
        let matchesTemp = matches[team]! + 1
        print("matchesTemp " + "\(matchesTemp)")
        
        matches[team] = matchesTemp
        
        if(matchesTemp >= maxMatches) {
            finish()
        } else {
            startMatch()
        }
    }
    
    func finish(){
        finished = true
    }
    
    func isFinished() -> Bool {
        return finished
    }
}