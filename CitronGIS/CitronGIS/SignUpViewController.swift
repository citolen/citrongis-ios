//
//  SignUpViewController.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 1/4/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmationLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmationField: UITextField!

    @IBOutlet weak var generalConditionBtn: UIButton!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBAction func pressBack(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let fontSize = self.view.frame.size.width * 0.035
        self.emailLabel.font = UIFont.systemFontOfSize(fontSize)
        self.passwordLabel.font = UIFont.systemFontOfSize(fontSize)
        self.emailField.font = UIFont.systemFontOfSize(fontSize)
        self.passwordField.font = UIFont.systemFontOfSize(fontSize)
        self.confirmationLabel.font = UIFont.systemFontOfSize(fontSize)
        self.passwordConfirmationField.font = UIFont.systemFontOfSize(fontSize)
        self.signUpBtn.layer.borderWidth = 1
        self.signUpBtn.layer.borderColor = self.emailLabel.backgroundColor?.CGColor
        self.signUpBtn.layer.cornerRadius = self.signUpBtn.frame.size.height / 8
        self.generalConditionBtn.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
