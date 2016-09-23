//
//  ViewController.swift
//  P1_Game
//
//  Created by Rohith Raju on 8/31/16.
//  Copyright © 2016 Rohith Raju. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var ballImg: UIImageView!
    var HorFlag = false
    var  VerFlag = false
    var timer: NSTimer!
    var life = 0
    
    var score = 0
    var ballClicked = AVAudioPlayer()
    var  wrongTouch = AVAudioPlayer()
    var audioPalyer = AVAudioPlayer()
    var difficulty = 0
    var timeInterval: Double = 0.0
    var  songName = ""
    var lifeReceived = 0
    var timeIntervalReceived = 0.0
    
    @IBOutlet weak var imageVie: UIImageView!
    @IBOutlet weak var lifeLbl: UILabel!
    
    @IBOutlet weak var scoreLbl: UILabel!
    
    @IBOutlet weak var restart: UIButton!
    
    func receiveParameters(name: String,Lifes: String,Diff: Int)  {
        
        life = Int(Lifes)!
        lifeReceived = life
        difficulty = Diff
        executeSwitchCase(Diff)
        
    }
    
    
    func executeSwitchCase(diff: Int){
        
        switch difficulty {
        case 0:
            timeIntervalReceived = 0.02
            timeInterval = 0.02
            songName = "uptown"
            break
        case 1:
            timeIntervalReceived = 0.01
            timeInterval = 0.01
            songName = "sia"
            break
        case 2:
            timeIntervalReceived = 0.007
            timeInterval = 0.007
            songName = "rap1"
            
            break
            
        default:
            break
        }

        
}
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // animateBall()
        let audioPath = NSBundle.mainBundle().pathForResource(songName, ofType: "mp3")
        do{
          
            try  audioPalyer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
            audioPalyer.volume = 0.8
            
        }catch
        {
            
        }
        
        
        startgame()
    }
    
    
    
    
    override func viewDidDisappear(animated: Bool) {
      //  wrongTouch.stop()
        audioPalyer.stop()
        
              //ballClicked.stop()
 
    }

    override func viewWillDisappear(animated: Bool) {
        
        
        imageVie.image = nil
        ballImg.image = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func BallTapped(sender: AnyObject) {
        
        let audioPath = NSBundle.mainBundle().pathForResource("click", ofType: "wav")
        do{
            
            try  ballClicked = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
            
            
        }catch
        {
            
        }
        
        
        ballClicked.play()
        ballClicked.volume = 0.3
        score = score + 25
        if score % 100 == 0{

            increaseDiificulty()
        }
        scoreLbl.text = "Score:\(score)"
        
      //  ballClicked.stop()
    }
    
    @IBAction func EndGame(sender: AnyObject) {
        
      stopGame()
      self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    @IBAction func Screentapped(sender: AnyObject) {
        let audioPath = NSBundle.mainBundle().pathForResource("fail", ofType: "mp3")
        do{
            
            try  wrongTouch = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
            
            
        }catch
        {
            
        }
        wrongTouch.play()

        life = life - 1

        if life <= 0 {
        
            stopGame()
            
        }else{
            lifeLbl.text = "Lifes:\(life)"
        }

    }
    
    
    func startgame(){

        score = 0
        life = lifeReceived
        lifeLbl.text = "Lifes:\(life)"
        scoreLbl.text = "Score:\(score)"
        audioPalyer.play()
        scheduleTimer(timeInterval)
    }
    
    func scheduleTimer(time: Double){
        dispatch_async(dispatch_get_main_queue()) { 
            self.timer = NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: #selector(ViewController.animateBall), userInfo: nil, repeats: true)

        }
        
    }
    
    func stpTimer(){
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.timer.invalidate()
        }
    }
    
    
    
    
    
    
    
    func alertView (){
        
        let namePlayer = NSUserDefaults.standardUserDefaults().valueForKey("playerName")!
        let alertController = UIAlertController(title: "\(namePlayer) you've scored \(score)", message: "", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: { action in  self.navigationController?.popViewControllerAnimated(true)})
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func stopGame(){
        
        // life = 0\      timer.invalidate()
        stpTimer()
        lifeLbl.text = "Lifes:\(life)"
        scoreLbl.text = "Score:\(score)"
        alertView()
        audioPalyer.stop()
        
    }
    
    func increaseDiificulty()
    {
        
        timeIntervalReceived = timeIntervalReceived - 0.001
        scheduleTimer(timeIntervalReceived)

        
    }
    
    
    
    
    
    
    func animateBall(){
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds

        if HorFlag == false {
            
          ballImg.center = CGPointMake(ballImg.center.x+3 , ballImg.center.y)
            
        }else{
            
           ballImg.center = CGPointMake(ballImg.center.x-3 , ballImg.center.y)
            
        }
        
        if ballImg.center.x + (ballImg.frame.size.width/2) > screenSize.width
        {
            
            print("ball:\(ballImg.center.x + (ballImg.frame.size.width/2)),screen:\(screenSize.width),ball width:\((ballImg.frame.size.width/2)),ball center:\(ballImg.center.x)")
            
            HorFlag = true
        }
        
        if ballImg.center.x + (ballImg.frame.size.width/2) <= ballImg.frame.size.width
        {
            print("ball:\(ballImg.center.x + (ballImg.frame.size.width/2)),ball:\(ballImg.frame.size.width),ball width:\((ballImg.frame.size.width/2)),ball center:\(ballImg.center.x)")
            HorFlag = false
        }

        
        if VerFlag == false {
            ballImg.center = CGPointMake(ballImg.center.x , ballImg.center.y+3)
        }else{
            ballImg.center = CGPointMake(ballImg.center.x , ballImg.center.y-3)
        }
        
        if ballImg.center.y + (ballImg.frame.size.height/2) > screenSize.height{
            VerFlag = true
        }
        
        if ballImg.center.y + (ballImg.frame.size.height/2)-70 <= ballImg.frame.size.height
        {
            VerFlag = false
        }

        
    }


    @IBAction func backCustom(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}

