//
//  ViewController.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 06/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var gameManager = GameManager();
    
    private var players = [Player]()
    
    private var draggedCell: PlayerTableViewCell = PlayerTableViewCell()
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var teamLeftOffenseButton: PlayerButton!
    
    @IBOutlet weak var teamLeftDefenseButton: PlayerButton!
    
    @IBOutlet weak var teamRightOffenseButton: PlayerButton!
    
    @IBOutlet weak var teamRightDefenseButton: PlayerButton!
    
    private var draggedCellIndexPath: NSIndexPath = NSIndexPath()
    
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
        players.appendContentsOf(
            [
                Player(id: 1, firstname: "Michael", lastname: "Hunger", ranking: 1),
                Player(id: 2, firstname: "Thomas", lastname: "Müller", ranking: 2),
                Player(id: 3, firstname: "Friedrich", lastname: "Lahm", ranking: 3),
                Player(id: 4, firstname: "Tina", lastname: "Treibel", ranking: 4),
                Player(id: 5, firstname: "Christian", lastname: "Herz", ranking: 5),
                Player(id: 6, firstname: "Tobias", lastname: "Krass", ranking: 6)
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
        
        cell.setPlayer(player)
        cell.firstName.text = player.getFirstname();
        cell.lastName.text = player.getLastname()
        cell.ranking.text = String(player.getRanking())
        
        return cell
    }
    
    @IBAction func increaseScoreTeamLeftOffense(sender: PlayerButton) {
        gameManager.increaseScore(
            Game.teamId.team1,
            player: sender.getPlayer(),
            opponent: Game.teamId.team2
        )
        
        setTeamScore()
    }
    
    @IBAction func increaseScoreTeamLeftDefense(sender: PlayerButton) {
        gameManager.increaseScore(
            Game.teamId.team1,
            player: sender.getPlayer(),
            opponent: Game.teamId.team2
        )
        
        setTeamScore()
    }

    @IBAction func increaseScoreTeamRightOffense(sender: PlayerButton) {
        gameManager.increaseScore(
            Game.teamId.team2,
            player: sender.getPlayer(),
            opponent: Game.teamId.team1
        )
        
        setTeamScore()
    }
    
    @IBAction func increaseScoreTeamRightDefense(sender: PlayerButton) {
        gameManager.increaseScore(
            Game.teamId.team2,
            player: sender.getPlayer(),
            opponent: Game.teamId.team1
        )
        
        setTeamScore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadSamplePlayers()
        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressGestureRecognized(_:)))
        playerTable.addGestureRecognizer(longpress)
        
        
        playerTable.delegate = self
        playerTable.dataSource = self
    }
    
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        struct My {
            
            static var cellSnapshot : UIView? = nil
            
        }
        struct Path {
            
            static var initialIndexPath : NSIndexPath? = nil
            
        }
        
        let longpress = gestureRecognizer as! UILongPressGestureRecognizer
        
        let state = longpress.state
        
        let locationInTableView = longpress.locationInView(playerTable)
        let locationInView = longpress.locationInView(self.view)
        
        let indexPath = playerTable.indexPathForRowAtPoint(locationInTableView)
        
        switch (state) {
        case UIGestureRecognizerState.Began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                
                draggedCellIndexPath = indexPath!
                draggedCell = playerTable.cellForRowAtIndexPath(indexPath!) as! PlayerTableViewCell
                
                My.cellSnapshot  = snapshopOfCell(draggedCell)
                
                My.cellSnapshot!.center.x = locationInView.x
                
                My.cellSnapshot!.center.y = locationInView.y
                
                My.cellSnapshot!.alpha = 0.90
                
                self.view.addSubview(My.cellSnapshot!)
                            }
        case UIGestureRecognizerState.Changed:
            var center = My.cellSnapshot!.center
            
            center.y = locationInView.y
            center.x = locationInView.x
            
            My.cellSnapshot!.center = center
        default:
            setPlayerIfDraggedOnButton(locationInView)
            
            draggedCell.hidden = false
            
            draggedCell.alpha = 0.0
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                
                My.cellSnapshot!.center = self.draggedCell.center
                
                My.cellSnapshot!.transform = CGAffineTransformIdentity
                
                My.cellSnapshot!.alpha = 0.0
                
                self.draggedCell.alpha = 1.0
                
                }, completion: { (finished) -> Void in
                    
                    if finished {
                        
                        Path.initialIndexPath = nil
                        
                        My.cellSnapshot!.removeFromSuperview()
                        
                        My.cellSnapshot = nil
                        
                    }
                    
            })
        }
    }
    
    func setPlayerIfDraggedOnButton(locationInView: CGPoint) {
        
        var teamid: Game.teamId?
        var side: Game.side?
        var position: Game.position?
        
        if(CGRectContainsPoint(teamLeftOffenseButton.frame, locationInView)) {
            teamLeftOffenseButton.setTitle("\(draggedCell.lastName.text!)", forState: UIControlState.Normal)
            teamLeftOffenseButton.setPlayer(draggedCell.getPlayer())
            teamid = Game.teamId.team1
            side = Game.side.dark
            position = Game.position.offense
            
        }
        
        if(CGRectContainsPoint(teamLeftDefenseButton.frame, locationInView)) {
            teamLeftDefenseButton.setTitle("\(draggedCell.lastName.text!)", forState: UIControlState.Normal)
            teamLeftDefenseButton.setPlayer(draggedCell.getPlayer())
            teamid = Game.teamId.team1
            side = Game.side.dark
            position = Game.position.defense
        }
        
        if(CGRectContainsPoint(teamRightOffenseButton.frame, locationInView)) {
            teamRightOffenseButton.setTitle("\(draggedCell.lastName.text!)", forState: UIControlState.Normal)
            teamRightOffenseButton.setPlayer(draggedCell.getPlayer())
            teamid = Game.teamId.team2
            side = Game.side.light
            position = Game.position.offense
        }
        
        if(CGRectContainsPoint(teamRightDefenseButton.frame, locationInView)) {
            teamRightDefenseButton.setTitle("\(draggedCell.lastName.text!)", forState: UIControlState.Normal)
            teamRightDefenseButton.setPlayer(draggedCell.getPlayer())
            teamid = Game.teamId.team2
            side = Game.side.light
            position = Game.position.defense
        }

        if(teamid != nil) {
            gameManager.addPlayer(teamid!,
                                  side: side!,
                                  pos: position!,
                                  player: draggedCell.getPlayer())
            print("\(gameManager)")
        }
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        
        UIGraphicsEndImageContext()
        
        let cellSnapshot : UIView = UIImageView(image: image)
        
        cellSnapshot.layer.masksToBounds = false
        
        cellSnapshot.layer.cornerRadius = 0.0
        
        cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        
        cellSnapshot.layer.shadowRadius = 5.0
        
        cellSnapshot.layer.shadowOpacity = 0.4
        
        return cellSnapshot
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startStopGame(sender: UIButton, forEvent event: UIEvent) {
        
        if(gameManager.isStarted()) {
            gameManager.stopGame()
            sender.setTitle("Start Game", forState: UIControlState.Normal)
        } else {
            gameManager.startGame()
            sender.setTitle("Stop Game", forState: UIControlState.Normal)
        }

        setTeamScore()
    }
    
    func setTeamScore() {
        
        teamOneScoreDisplayValue = gameManager.getTeamScore(Game.teamId.team1)
        teamTwoScoreDisplayValue = gameManager.getTeamScore(Game.teamId.team2)
        
        setMatches()
        setStartButton()
        
    }
    
    func setStartButton() {
        if(!gameManager.isStarted()) {
            print("Set start button to start")
            startButton!.setTitle("Start Game", forState: UIControlState.Normal)
        }
    }
    
    func setMatches(){
        var matches = gameManager.getTeamMatches()
        
        if(matches[Game.teamId.team1] > 0) {
            teamOneMatchOne.backgroundColor = UIColor.blackColor()
        } else {
            teamOneMatchOne.backgroundColor = UIColor.clearColor()
        }
        
        if(matches[Game.teamId.team1] > 1) {
            teamOneMatchTwo.backgroundColor = UIColor.blackColor()
        } else {
            teamOneMatchTwo.backgroundColor = UIColor.clearColor()
        }
        
        if(matches[Game.teamId.team2] > 0) {
            teamTwoMatchOne.backgroundColor = UIColor.blackColor()
        } else {
            teamTwoMatchOne.backgroundColor = UIColor.clearColor()
        }
        
        if(matches[Game.teamId.team2] > 1) {
            teamTwoMatchTwo.backgroundColor = UIColor.blackColor()
        } else {
            teamTwoMatchTwo.backgroundColor = UIColor.clearColor()
        }
    }
}

