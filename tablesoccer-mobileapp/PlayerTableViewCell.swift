//
//  PlayerTableViewCell.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 10/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var ranking: UILabel!
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    private var player: Player?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPlayer(player: Player) {
        self.player = player
    }
    
    func getPlayer() -> Player{
        return player!
    }
}
