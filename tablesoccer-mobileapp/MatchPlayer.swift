//
//  MatchPlayer.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 10/05/16.
//  Copyright © 2016 Michael Hunger. All rights reserved.
//

import Foundation

class MatchPlayer {
    private var player: Player?
    
    private var position: Game.position?
    
    private var goals = 0
    
    init () {
        
    }
    
    init (player: Player, position: Game.position) {
        self.player = player
        self.position = position
    }
    
    func increaseScore() {
        goals += 1
    }
}