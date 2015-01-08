//
//  CitronGISMainViewController.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 11/11/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

import UIKit
import JavaScriptCore
import MessageUI

class CitronGISMainViewController: CCDirectorDisplayLink, PullableViewDelegate {

    let scriptToLoad = ["jszip",
                        "proj4",
                        "ejs",
                        "EventEmitter",
                        "Comparison",
                        "Intersection",
                        "Inheritance",
                        "Object",
                        "Context",
                        "Path",
                        "Point",
                        "Vector2",
                        "Vector3",
                        "BoundingBox",
                        "CoordinatesHelper",
                        "ProjectionsHelper",
                        "Require",
                        "include",
                        "trigger",
                        "Bridge",
                        "UI",
                        "Module",
                        "Extension",
                        "Manager"]
    var pullRightView:StyledPullableView!
    var webView:UIWebView!
    var jscontext:JSContext!
    var storyboardCG:UIStoryboard!
    
    override init() {
        super.init()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupExtensions()
        UITabBar.appearance().tintColor = UIColor(red: 0, green: 148/255.0, blue: 130/255.0, alpha: 1.0)
        storyboardCG = UIStoryboard(name: "CitrongisStoryboard", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (pullRightView == nil)
        {
            self.setupInterface()
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func addTestExtension()
    {
        var filePath = NSBundle.mainBundle().pathForResource("citrongis-app", ofType: "zip")
        var data = NSFileManager.defaultManager().contentsAtPath(filePath!)
        
        var base64Str = data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
        
        filePath = NSBundle.mainBundle().pathForResource("test", ofType: "js")
        data = NSFileManager.defaultManager().contentsAtPath(filePath!)
        let script = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        var re = self.jscontext.evaluateScript(script)
//        println("\(re.toBool()), \(re.description)");
        
        
        re = self.jscontext.evaluateScript("fileChanged(\"\(base64Str!)\");")
        
        
        filePath = NSBundle.mainBundle().pathForResource("chat", ofType: "zip")
        data = NSFileManager.defaultManager().contentsAtPath(filePath!)
        base64Str = data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
        re = self.jscontext.evaluateScript("fileChanged(\"\(base64Str!)\");")
        
        filePath = NSBundle.mainBundle().pathForResource("chat1", ofType: "zip")
        data = NSFileManager.defaultManager().contentsAtPath(filePath!)
        base64Str = data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
        re = self.jscontext.evaluateScript("fileChanged(\"\(base64Str!)\");")
        self.jscontext.evaluateScript(base64Str)
        
        
//        println("test extension : \(re.toBool()), \(re.description)");
        
    }
    func setupExtensions()
    {
        webView = UIWebView()
        self.jscontext = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as JSContext
        
        var block : @objc_block (NSString!) -> Void = {
            (string : NSString!) -> Void in
            println("\(string)")
        }
        jscontext.setObject(unsafeBitCast(block, AnyObject.self), forKeyedSubscript: "log")
        
        jscontext.exceptionHandler = {(context : JSContext!, val : JSValue!) -> Void in
            println(val.description)
        }
//        jscontext.evaluateScript("log('toto')")
        for toload in scriptToLoad
        {
            
            let filePath = NSBundle.mainBundle().pathForResource(toload, ofType: "js")
            let data = NSFileManager.defaultManager().contentsAtPath(filePath!)
            let script = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            let re = self.jscontext.evaluateScript(script)
//            println("\(re.toBool()), \(re.description), \(self.jscontext.exception.description)");
            if (self.jscontext.exception != nil)
            {
                println(self.jscontext.exception.description)
            }
//            toload
        }
//
    }
    
    func setupInterface()
    {
        pullRightView = StyledPullableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        pullRightView.backgroundColor = UIColor.clearColor()
        pullRightView.closedCenter = CGPointMake(-self.view.frame.size.width * 0.395, pullRightView.frame.size.height / 2.0)
        pullRightView.openedCenter = CGPointMake(self.view.frame.size.width / 2.0, pullRightView.frame.size.height / 2.0)
        pullRightView.center = pullRightView.closedCenter
        pullRightView.animate = true
        pullRightView.handleView.frame = CGRectMake(0, 0, self.view.frame.size.width, pullRightView.frame.size.height)
        
        let sqWidth = (self.pullRightView.frame.size.width - self.pullRightView.frame.size.width * 0.129) / 2.0
        var account_btn = UIButton(frame: CGRectMake(0, 0, sqWidth, sqWidth))
        
        account_btn.backgroundColor = UIColor(red: 103.0/256.0, green: 187.0/256.0, blue: 156.0/256.0, alpha: 1.0)
        account_btn.setImage(UIImage(named: "my_account"), forState: UIControlState.Normal)
        account_btn.addTarget(self, action: "pressAccount", forControlEvents: UIControlEvents.TouchUpInside)
        pullRightView.addSubview(account_btn)
        
        var shopBtn = UIButton(frame: CGRectMake(sqWidth, 0, sqWidth, sqWidth))
        shopBtn.backgroundColor = UIColor(red: 112.0/256.0, green: 204.0/256.0, blue: 112.0/256.0, alpha: 1.0)
        shopBtn.setImage(UIImage(named: "shop"), forState: UIControlState.Normal)
        shopBtn.addTarget(self, action: "pressStore", forControlEvents: UIControlEvents.TouchUpInside)
        pullRightView.addSubview(shopBtn)
        
        var searchBtn = UIButton(frame: CGRectMake(0, sqWidth, sqWidth, sqWidth))
        searchBtn.backgroundColor = UIColor(red: 241.0/256.0, green: 196.0/256.0, blue: 7.0/256.0, alpha: 1.0)
        searchBtn.setImage(UIImage(named: "search"), forState: UIControlState.Normal)
        pullRightView.addSubview(searchBtn)
        
        var settingsBtn = UIButton(frame: CGRectMake(sqWidth, sqWidth, sqWidth, sqWidth))
        settingsBtn.backgroundColor = UIColor(red: 229.0/256.0, green: 126.0/256.0, blue: 34.0/256.0, alpha: 1.0)
        settingsBtn.setImage(UIImage(named: "settings"), forState: UIControlState.Normal)
        pullRightView.addSubview(settingsBtn)
        
        var menuBtn = UIButton(frame: CGRectMake(0, sqWidth * 2, sqWidth, sqWidth))
        menuBtn.backgroundColor = UIColor(red: 83.0/256.0, green: 152.0/256.0, blue: 118.0/256.0, alpha: 1.0)
        menuBtn.setImage(UIImage(named: "menu"), forState: UIControlState.Normal)
        pullRightView.addSubview(menuBtn)
        
        var lastBtn = UIButton(frame: CGRectMake(sqWidth, sqWidth * 2, sqWidth, sqWidth))
        lastBtn.backgroundColor = UIColor(red: 155.0/256.0, green: 89.0/256.0, blue: 182.0/256.0, alpha: 1.0)
        pullRightView.addSubview(lastBtn)
        
        self.webView.frame = self.view.frame
        
        self.webView.backgroundColor = UIColor.clearColor()
        self.webView.opaque = false
        
        
        self.view.addSubview(webView)
        self.view.addSubview(pullRightView)
        
        self.addTestExtension();
        
    }
    
    func pressAccount()
    {
        let vc = self.storyboardCG?.instantiateViewControllerWithIdentifier("mainNavigation")! as UIViewController
        self.navigationController?.presentViewController(vc, animated: true, completion: { () -> Void in
            
        })
    }
    func pressStore()
    {
        let vc = self.storyboardCG?.instantiateViewControllerWithIdentifier("storeNavigation")! as UIViewController
        self.navigationController?.presentViewController(vc, animated: true, completion: { () -> Void in
            
        })

    }
    func pullableView(pView: PullableView!, didChangeState opened: Bool) {
        
    }
    
    func pullableView(pView: PullableView!, willChangeState opened: Bool, withDuration duration: Float) {
        
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
