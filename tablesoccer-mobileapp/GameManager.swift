//
//  Game.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 06/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import Foundation

class GameManager: NSObject {
    
    private var currentGame: Game?
    
    private var started: Bool = false
    
    private var finished: Bool = false

    private var maxGoals: Int = 10
    
    private var winningScore: Int = 7
    
    private var maxMatches: Int = 2
    
    override init() {
        super.init()
        initGame()
    }
    
    func addPlayer(team:Game.teamId, player: Player) {
        currentGame!.addPlayer(team, player: player)
    }
    
    func initGame() {
        currentGame = Game(maxGoals: maxGoals, winningScore: winningScore, maxMatches: maxMatches)
    }
    
    func startGame() {
        initGame()
        currentGame!.start();
        started = true
    }
    
    func stopGame() {
        saveGame()
        
        let previousTeams = currentGame!.getTeams()
        
        initGame()
        started = false
        currentGame!.setTeams(previousTeams)
    }
    
    func isStarted() -> Bool {
        return started
    }
    
    func getTeamScore(team: Game.teamId) -> Int{
        return currentGame!.getTeamScore(team)
    }
    
    func getTeamMatches() -> [Game.teamId:Int]{
        return currentGame!.getTeamMatches()
    }
    
    func increaseScore(scorer: Game.teamId, opponent: Game.teamId) {
        currentGame!.increaseScore(scorer, opponent: opponent)
        
        if(currentGame!.isFinished()) {
            stopGame()
        }
    }
    
    func finishGame(){
        currentGame!.finish()
    }
    
    func isCurrentGameFinished() -> Bool {
        return currentGame!.isFinished()
    }
    
    func saveGame() {
        //code to save game to core data here
    }
}