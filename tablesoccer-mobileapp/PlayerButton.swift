//
//  PlayerButton.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 16/05/16.
//  Copyright © 2016 Michael Hunger. All rights reserved.
//

import UIKit

class PlayerButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    private var player: Player?
    
    func setPlayer(player: Player) {
        self.player = player
    }
    
    func getPlayer () -> Player {
        return player!
    }
    
}
