//
//  Player.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 10/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import Foundation

class Player {
    private var firstname: String = ""
    
    private var lastname: String = ""
    
    private var ranking: Int
    
    init(firstname: String, lastname: String, ranking: Int) {
        self.firstname = firstname
        self.lastname = lastname
        self.ranking = ranking
    }
    
    func getFirstname() -> String {return firstname}
    
    func getLastname() -> String {return lastname}
    
    func getRanking() -> Int {return ranking}
}