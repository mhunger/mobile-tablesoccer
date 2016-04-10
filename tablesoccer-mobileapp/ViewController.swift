//
//  ViewController.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 06/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var game: Game = Game();
    
    var players = [Player]()
    
    @IBOutlet weak var teamOneScore: UILabel!
    
    @IBOutlet weak var teamTwoScore: UILabel!
    
    @IBOutlet weak var teamOneMatchOne: UILabel!
    
    @IBOutlet weak var teamOneMatchTwo: UILabel!
    
    @IBOutlet weak var teamTwoMatchOne: UILabel!
    
    @IBOutlet weak var teamTwoMatchTwo: UILabel!
    
    @IBOutlet weak var playerTable: UITableView!
    
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
    
    /*
    * Load some static Players. This will come from backend
    * later
    */
    func loadSamplePlayers() {
        players.extend(
            [
                Player(firstname: "Michael", lastname: "Hunger", ranking: 1),
                Player(firstname: "Thomas", lastname: "Müller", ranking: 2),
                Player(firstname: "Friedrich", lastname: "Lahm", ranking: 3),
                Player(firstname: "Tina", lastname: "Treibel", ranking: 4),
                Player(firstname: "Christian", lastname: "Herz", ranking: 5),
                Player(firstname: "Tobias", lastname: "Krass", ranking: 6)
            ]
        )
    }
    
    /*
     * These are the table functions
     * Defines how many sections in the table
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    /*
     * This defines how many rows in the sections
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return players.count
    }
    
    /*
     * This is called to build and configure the cell. First the
     * the cell is retrieved, filled with its contents and then 
     * returned
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayerTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PlayerTableViewCell
        
        let player = players[indexPath.row]
        
        cell.firstName.text = player.getFirstname();
        cell.lastName.text = player.getLastname()
        cell.ranking.text = String(player.getRanking())
        
        return cell
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
        
        loadSamplePlayers()
        
        playerTable.delegate = self
        playerTable.dataSource = self
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

