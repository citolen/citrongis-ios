//
//  SignInViewController.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 12/21/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rememberMeLabel: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var iDontRememberBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBAction func pressBack(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    @IBAction func pressSignUp(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("signup")! as! UIViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func pressSignIn(sender: AnyObject) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let fontSize = self.view.frame.size.width * 0.035
        self.emailLabel.font = UIFont.systemFontOfSize(fontSize)
        self.passwordLabel.font = UIFont.systemFontOfSize(fontSize)
        self.emailField.font = UIFont.systemFontOfSize(fontSize)
        self.passwordField.font = UIFont.systemFontOfSize(fontSize)
        
        self.signInBtn.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        self.signUpBtn.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        self.iDontRememberBtn.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        self.rememberMeLabel.font = UIFont.systemFontOfSize(fontSize)
        
        self.signInBtn.layer.borderWidth = 1
        self.signInBtn.layer.borderColor = self.emailLabel.backgroundColor?.CGColor
        self.signInBtn.layer.cornerRadius = self.signInBtn.frame.size.height / 8
        
        self.signUpBtn.layer.borderWidth = 1
        self.signUpBtn.layer.borderColor = self.emailLabel.backgroundColor?.CGColor
        self.signUpBtn.layer.cornerRadius = self.signUpBtn.frame.size.height / 8
        
        self.iDontRememberBtn.layer.borderWidth = 1
        self.iDontRememberBtn.layer.borderColor = self.emailLabel.backgroundColor?.CGColor
        self.iDontRememberBtn.layer.cornerRadius = self.iDontRememberBtn.frame.size.height / 8
        
        self.title = NSLocalizedString("sign_in_title", comment: "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
