//
//  Team.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 17/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import Foundation

class Team {
    private var player1: Player?
    
    private var player2: Player?
    
    func addPlayer(player: Player) {
        if(player1 == nil) {
            player1 = player
        } else if (player2 == nil) {
            player2 = player
        }
    }
}