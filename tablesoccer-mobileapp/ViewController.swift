//
//  ViewController.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 06/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var game: Game = Game();
    
    @IBOutlet weak var teamOneScore: UILabel!
    
    @IBOutlet weak var teamTwoScore: UILabel!
    
    @IBOutlet weak var teamOneMatchOne: UILabel!
    
    @IBOutlet weak var teamOneMatchTwo: UILabel!
    
    @IBOutlet weak var teamTwoMatchOne: UILabel!
    
    @IBOutlet weak var teamTwoMatchTwo: UILabel!
    
    var teamOneScoreDisplayValue: Int{
        get{
            return NSNumberFormatter().numberFromString(teamOneScore.text!)!.integerValue
        }
        
        set{
            teamOneScore.text = "\(newValue)"
        }
    }
    
    var teamTwoScoreDisplayValue: Int{
        get{
            return NSNumberFormatter().numberFromString(teamTwoScore.text!)!.integerValue
        }
        
        set{
            teamTwoScore.text = "\(newValue)"
        }
    }
    
    @IBAction func increaseScoreTeamOnePlayerOne(sender: UIButton) {
        game.increaseScore(
            Game.teamId.team1,
            opponent: Game.teamId.team2
        )
        
        setTeamScore()
    }
    
    @IBAction func increaseScoreTeamOnePlayerTwo(sender: UIButton) {
        game.increaseScore(
            Game.teamId.team1,
            opponent: Game.teamId.team2
        )
        
        setTeamScore()
    }
    
    @IBAction func increaseScoreTeamTwoPlayerOne(sender: UIButton) {
        game.increaseScore(
            Game.teamId.team2,
            opponent: Game.teamId.team1
        )
        
        setTeamScore()
    }
    
    @IBAction func increaseScoreTeamTwoPlayerTwo(sender: UIButton) {
        game.increaseScore(
            Game.teamId.team2,
            opponent: Game.teamId.team1
        )
        
        setTeamScore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startStopGame(sender: UIButton, forEvent event: UIEvent) {
        
        if(game.isStarted()) {
            game.stopGame()
            sender.setTitle("Start Game", forState: UIControlState.Normal)
        } else {
            game.startGame()
            sender.setTitle("Stop Game", forState: UIControlState.Normal)
        }

        setTeamScore()
    }
    
    func setTeamScore() {
        
        teamOneScoreDisplayValue = game.getTeamScore(Game.teamId.team1)
        teamTwoScoreDisplayValue = game.getTeamScore(Game.teamId.team2)
        
        setMatches()
        
    }
    
    func setMatches(){
        var matches = game.getTeamMatches()
        print(matches)
        println()
        
        if(matches[Game.teamId.team1] > 0) {
            teamOneMatchOne.backgroundColor = UIColor.blackColor()
            print("writing color")
        }
        
        if(matches[Game.teamId.team1] > 1) {
            teamOneMatchTwo.backgroundColor = UIColor.blackColor()
        }
        
        if(matches[Game.teamId.team2] > 0) {
            teamTwoMatchOne.backgroundColor = UIColor.blackColor()
        }
        
        if(matches[Game.teamId.team2] > 1) {
            teamTwoMatchTwo.backgroundColor = UIColor.blackColor()
        }
    }
}

