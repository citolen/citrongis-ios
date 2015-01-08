//
//  GeneralConditionsViewController.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 1/5/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import UIKit

class GeneralConditionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fontSize = self.view.frame.size.width * 0.035
        self.acceptBtn.layer.borderWidth = 1
        self.acceptBtn.layer.borderColor = self.acceptBtn.titleLabel?.textColor.CGColor
        self.acceptBtn.layer.cornerRadius = self.acceptBtn.frame.size.height / 8
        self.acceptBtn.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
        self.declineBtn.layer.borderWidth = 1
        self.declineBtn.layer.borderColor = self.declineBtn.titleLabel?.textColor.CGColor
        self.declineBtn.layer.cornerRadius = self.declineBtn.frame.size.height / 8
        self.declineBtn.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
