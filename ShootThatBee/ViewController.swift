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
    @IBOutlet weak var centerBeeR1: UIButton!
    @IBOutlet weak var stopButton: UIButton!    
    
    var gameIsOn: Bool = false
    var numOfLoopsToRun = 10
    var currLoop = 0
    var delay = 0.0
    var time: dispatch_time_t!
    
    let secsPerTick = 1.0
    
    
    @IBAction func startPlaying(sender: UIButton) {

        delay = secsPerTick * Double(NSEC_PER_SEC)

        tapLabel.hidden = true
        startButton.hidden = true
        stopButton.hidden = false
        gameIsOn = true
        currLoop = 0
        nextGameLoop()
    }
    
    @IBAction func stopPlayer(sender: UIButton) {
        gameIsOn = false
    }
    
    @IBAction func tapOnBee(sender: UIButton) {
        sender.setImage(UIImage(named: "Poof.png"), forState: UIControlState.Normal)
        
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
            tapLabel.hidden = false
            startButton.hidden = false
            stopButton.hidden = true
            centerBeeR1.hidden = true
        }
    }
    

    func executeGameLoop() {
        
        // reset the image of the bees
        centerBeeR1.setImage(UIImage(named: "SunglassBee.png"), forState: UIControlState.Normal)
        

        if centerBeeR1.hidden == false {
            centerBeeR1.hidden = true
        } else {
            centerBeeR1.hidden = false
        }

        currLoop += 1
        if currLoop > numOfLoopsToRun {
            gameIsOn = false
        }
        
        nextGameLoop()
        
    }

}

