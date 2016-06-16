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
    
    private var matchScore = [teamId:Int]()
    
    private var matches = [teamId:Match]()
    
    private var maxGoals: Int
    
    private var winningScore: Int
    
    private var maxMatches: Int
    
    private var teams = [teamId: Team]()
    
    private var currentMatch: Match?
    
    override  var description: String {
        return "team: \(teams) matches: \(matchScore)"
    }
    
    enum teamId {
        case team1
        case team2
    }
    
    enum position {
        case offense
        case defense
    }
    
    enum side {
        case dark
        case light
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
    
    func addPlayer(team:teamId, side: Game.side, position: Game.position, player: Player) {
        teams[team]!.addPlayer(team, position: position, player: player)
        teams[team]!.setSide(side)
        
        currentMatch!.addPlayer(
            team,
            side: side,
            position:  position,
            player: MatchPlayer(player: player, position: position)
        )
    }
    
    func start() {
        matchScore[teamId.team1] = 0
        matchScore[teamId.team2] = 0
        
        startMatch()
    }
    
    func startMatch() {
        currentMatch = Match(winningScore: winningScore, maxGoals: maxGoals)
    }
    
    func getTeamScore(team: teamId) -> Int{
        return currentMatch!.getScoreForTeam(team)
    }
    
    func getTeams() -> [Game.teamId:Team] {
        return teams
    }
    
    func getTeamMatches() -> [teamId:Int]{
        return matchScore
    }
    
    func setTeams(teams: [Game.teamId:Team]) {
        self.teams = teams
    }
    
    func increaseScore(scorer: teamId, player: Player, opponent: teamId) {
        
        currentMatch!.increaseScore(scorer, side: getSide(scorer), position: getPositionForPlayer(player), opponent: opponent)
        
        if(currentMatch!.isFinished()) {
            finishMatch(currentMatch!.getWinner())
        }
    }
    
    private func getSide(player: teamId) -> side {
        return teams[player]!.getSide()
    }
    
    private func getPositionForPlayer(player: Player) -> position {
        //@TODO add logic to get position of player from teams
        return Game.position.defense
    }
    
    func finishMatch(team: teamId) {
        let matchesTemp = matchScore[team]! + 1
        print("matchesTemp " + "\(matchesTemp)")
        
        matchScore[team] = matchesTemp
        
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