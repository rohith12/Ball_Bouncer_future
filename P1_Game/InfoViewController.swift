//
//  InfoViewController.swift
//  P1_Game
//
//  Created by Rohith Raju on 9/1/16.
//  Copyright © 2016 Rohith Raju. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserPic: UIImageView!
    
    @IBOutlet weak var appDescription: UITextView!
    
    @IBOutlet weak var InfoFetched: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserPic.layer.cornerRadius =  60.0
        UserPic.layer.masksToBounds = true
        UserPic.layer.borderColor = UIColor.orangeColor().CGColor
        UserPic.layer.borderWidth =  5.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        imgView.image = nil
    }
    
    override func viewWillAppear(animated: Bool) {
        imgView.image = UIImage(named: "491120")

    }
    
    @IBAction func Backk(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
