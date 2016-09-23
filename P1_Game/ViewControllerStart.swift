//
//  ViewControllerStart.swift
//  P1_Game
//
//  Created by Rohith Raju on 9/1/16.
//  Copyright © 2016 Rohith Raju. All rights reserved.
//

import UIKit

class ViewControllerStart: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var headerlbl: UILabel!
    @IBOutlet weak var ballBouncerLbl: UILabel!
    @IBOutlet weak var segmentIndex: UISegmentedControl!
    @IBOutlet weak var numberOfLifes: UITextField!
    @IBOutlet weak var nametxt: UITextField!
    var numOfLifesVar = "3"
    var difficulty = 0
    var PlayerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        imgView.image = UIImage(named: "491120")

//        nametxt.center.x -= 100
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        
        
//        UIView.animateWithDuration(0.5, delay: 0.3, options: [], animations: {
//            self.nametxt.center.x += 100
//            }, completion: nil)
    }

    override func viewWillDisappear(animated: Bool) {
        imgView.image = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start(sender: AnyObject) {
        
        if nametxt.text?.characters.count > 0 {
            
          PlayerName = nametxt.text!
          NSUserDefaults.standardUserDefaults().setObject(PlayerName, forKey: "playerName")
            
            if numberOfLifes.text?.characters.count > 0 {
                numOfLifesVar = numberOfLifes.text!
            }else{
                
                numOfLifesVar = "3"
            }
            
            
            
            
            
            difficulty = segmentIndex.selectedSegmentIndex
           performSegueWithIdentifier("start", sender: self)
            print("name:\(PlayerName)")
        }
        else{
            
            alertViewFunc("Please enter your name")
            
        }
        
        
        
    }
    
    func alertViewFunc(msg: String)  {
        
        
        let alertController = UIAlertController(title: "\(msg)", message: "", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)

    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "start" {
            
            if let destVC = segue.destinationViewController as? ViewController {
                destVC.receiveParameters(PlayerName, Lifes: numOfLifesVar, Diff: difficulty)
            }
          
        }
        
        
    }

    @IBAction func info(sender: AnyObject) {
        
        performSegueWithIdentifier("info", sender: self)
    }

}
