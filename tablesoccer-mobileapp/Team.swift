//
//  Team.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 17/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import Foundation

class Team: NSObject {
    private var team: Game.teamId?
    
    private var player1: Player?
    
    private var player2: Player?
    
    private var pos = Dictionary<Int, Game.position>()
    
    private var side: Game.side?
    
    override  var description: String {
        return "\(player1?.getFirstname()) \(player2?.getFirstname())"
    }
    
    func addPlayer(team: Game.teamId, position: Game.position, player: Player) {
        if(player1 == nil) {
            player1 = player
        } else if (player2 == nil) {
            player2 = player
        }
        
        self.pos[player.getId()] = position
        self.team = team
    }
    
    func getPositionForPlayerId(id: Int) -> Game.position {
        return Game.position.defense
    }
    
    func getSide() -> Game.side {
        return self.side!
    }
    
    func switchSides() {
        
    }
    
    func switchPosition(team: Game.teamId) {
        
    }
    
    func setSide(side: Game.side) {
        self.side = side
    }
}