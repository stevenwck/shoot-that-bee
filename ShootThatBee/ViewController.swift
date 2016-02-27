//
//  ViewController.swift
//  ShootThatBee
//
//  Created by Steven Wong on 27/02/2016.
//  Copyright © 2016 Steven CK Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var centerBeeR1: UIButton!
    @IBOutlet weak var leftBeeR1C1: UIButton!
    @IBOutlet weak var rightBeeR1C1: UIButton!

    var gameIsOn: Bool = false
    var numOfLoopsToRun = 10
    var delay = 0.0
    var time: dispatch_time_t!
    var score: Int = 0
    var highestPotentialScore: Int = 0
    
    let secsPerTick = 1.0
    
    
    @IBAction func startPlaying(sender: UIButton) {

        delay = secsPerTick * Double(NSEC_PER_SEC)

        logo.hidden = true
        tapLabel.hidden = true
        startButton.hidden = true
        stopButton.hidden = false
        currentScoreLabel.hidden = false
        scoreLabel.hidden = false
        resetScore()
        gameIsOn = true
        nextGameLoop()
    }
    
    @IBAction func stopPlaying(sender: UIButton) {
        gameIsOn = false
    }
    
    @IBAction func tapOnBee(sender: UIButton) {
        setBeeImagePoof(sender)
        sender.enabled = false
        incrementScore()
        
    }
    
    func nextGameLoop() {
        // wait for the next tick if game is still on
        if gameIsOn {
            time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                //put your code which should be executed with a delay here
                self.executeGameLoop()
            }
        }
        else {
            // game is ended
            endGame()
        }
    }
    

    func executeGameLoop() {
        // resetShotBee(centerBeeR1)
        
        showOrHideBee(centerBeeR1)
        showOrHideBee(leftBeeR1C1)
        showOrHideBee(rightBeeR1C1)
        
        updateScoreBoard()
        nextGameLoop()
    }

    
    func endGame() {
        logo.hidden = false
        tapLabel.hidden = false
        startButton.hidden = false
        stopButton.hidden = true
        centerBeeR1.hidden = true
        scoreLabel.hidden = true
        currentScoreLabel.hidden = true
        centerBeeR1.hidden = true
        rightBeeR1C1.hidden = true
        leftBeeR1C1.hidden = true
    }
    
    func showOrHideBee(bee: UIButton) {
        var randomNum = Int32(arc4random_uniform(100))
        
        // check if the bee has been shot.
        if bee.enabled == false {
            // if bee has been shot, it should dissappear
            randomNum = 1
        }
        
        if randomNum >= 50 {
            if bee.hidden == true {
                // means the bee just appeared, hence its a new bee that could be shot.
                highestPotentialScore += 1
            }
            bee.hidden = false
            bee.enabled = true
        } else {
            bee.hidden = true
            resetShotBee(bee)
        }
        
        
    }
    
    
    func setBeeImagePoof(bee: UIButton) {
        bee.setImage(UIImage(named: "Poof.png"), forState: UIControlState.Normal)
    }
    
    func resetShotBee(bee: UIButton) {
        // reset the image of the bees
        bee.setImage(UIImage(named: "SunglassBee.png"), forState: UIControlState.Normal)
        bee.enabled = true
    }
    
    func incrementScore() {
        score += 1
        updateScoreBoard()
    }
    
    func resetScore() {
        score = 0
        highestPotentialScore = 0
        updateScoreBoard()
    }
    
    func updateScoreBoard() {
        currentScoreLabel.text = "\(score) / \(highestPotentialScore)"
    }

}

