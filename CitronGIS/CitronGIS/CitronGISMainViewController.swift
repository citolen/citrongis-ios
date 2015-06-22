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

class CitronGISMainViewController: CCDirectorDisplayLink, PullableViewDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate {

    var layerManager:LayerManager!
    var viewport:Viewport!
    var currentScene:CCScene!
    var renderer:RendererBase!
    
    var pangesture:UIPanGestureRecognizer!
    var pinchGesture:UIPinchGestureRecognizer!
    var firstX:CGFloat!
    var firstY:CGFloat!
    var firstZ:Double!
    
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
    
//    override init() {
//        super.init()
//    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupExtensions()
        UITabBar.appearance().tintColor = UIColor(red: 0, green: 148/255.0, blue: 130/255.0, alpha: 1.0)
        storyboardCG = UIStoryboard(name: "CitrongisStoryboard", bundle: NSBundle.mainBundle())
        
        
    }
    
    override func mainLoop(sender: AnyObject!) {
        super.mainLoop(sender)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func didPinch(sender:UIPinchGestureRecognizer!)
    {
        var scale = sender.scale
        if (sender.state == UIGestureRecognizerState.Began) {
            firstZ = Double(scale)
        }
        else if (sender.state == UIGestureRecognizerState.Ended)
        {
            firstZ = nil
        }
        else
        {
            var d = (firstZ - Double(scale)) / 2.0
            self.viewport.zoom(self.viewport.resolution * (1 + d))
            firstZ = Double(scale)
            self.renderer.updatePositions(layerManager)
        }
    }
    func didPan(sender:UIPanGestureRecognizer!)
    {
        var translatedPoint = sender.translationInView(self.webView)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            firstX = 0
            firstY = 0
        }
        else if (sender.state == UIGestureRecognizerState.Ended)
        {
            firstX = nil
            firstY = nil
        }
        else
        {
            self.viewport.translate(Double(firstX - translatedPoint.x), ty: Double(firstY - translatedPoint.y))
            firstX = translatedPoint.x
            firstY = translatedPoint.y
            self.renderer.updatePositions(layerManager)
        }
        
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
        if (self.currentScene != nil)
        {
            self.currentScene.removeAllChildren()
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        viewport = Viewport(width: UInt(self.view.frame.size.width) , andHeight: UInt(self.view.frame.size.height), andResolution: ResolutionHelper.resolutionReference(), andSchema: SphericalMercator(), andOrigin: Vector2(fromPosx: 0, andY: 0), andRotation: 0)
        layerManager = LayerManager()
        renderer = CocosRenderer(layerManager: layerManager, andScene: CCDirector.sharedDirector().runningScene, andViewPort: viewport)
        webView.scrollView.scrollEnabled = false
        webView.addGestureRecognizer(pangesture)
        webView.addGestureRecognizer(pinchGesture)
        self.currentScene = CCDirector.sharedDirector().runningScene
        
        
        
        let grp = Group()
        layerManager.addGroup(grp)
        
        
//        let tiles = TileLayer(tileSource: , tileSchema: SphericalMercator())
        let tiles = TileLayer(tileSource: TMSSource(sourceUrl: "http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}.png", sourceServer: nil), tileSchema: TileSphericalMercator())
        
        let layer = Layer()
        grp.addLayer(tiles)
        grp.addLayer(layer)
        
        
        
        let feature2 = Circle()
        feature2.setRadius(3.0)
        feature2.setBorderWidth(2.0)
        feature2.setBorderColor(CCColor.yellowColor())
        feature2.setColor(CCColor.redColor())
        feature2.location = GeometryPoint(fromPosx: 2.346030, andY:48.851913, andZ: 0, andProj: ProjectionHelper.WSG84())
        layer.addFeature(feature2);
        
        let feature4 = Polygon()
        feature4.setBorderColor(CCColor.redColor())
        feature4.setColor(CCColor.yellowColor())
        feature4.addVertex(GeometryPoint(fromPosx: -68.288577, andY:-55.679726 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        feature4.addVertex(GeometryPoint(fromPosx:-70.573733, andY:-18.316418 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        feature4.addVertex(GeometryPoint(fromPosx:-81.823733, andY:-5.094729 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        feature4.addVertex(GeometryPoint(fromPosx:-73.913577, andY:12.722377 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        feature4.addVertex(GeometryPoint(fromPosx:-34.187013, andY:-6.493759 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        layer.addFeature(feature4)
        
        
        
        let feature5 = Polyline()
        feature5.setLineWidth(1.0)
        feature5.setColor(CCColor.purpleColor())
        feature5.addVertex(GeometryPoint(fromPosx: -40.288577, andY:-55.679726 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        feature5.addVertex(GeometryPoint(fromPosx:-42.573733, andY:-18.316418 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        feature5.addVertex(GeometryPoint(fromPosx:-53.823733, andY:-5.094729 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        feature5.addVertex(GeometryPoint(fromPosx:-45.913577, andY:12.722377 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        feature5.addVertex(GeometryPoint(fromPosx:-6.187013, andY:-6.493759 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        feature5.addVertex(GeometryPoint(fromPosx: -40.288577, andY:-55.679726 , andZ: 0, andProj: ProjectionHelper.WSG84()))
        
        layer.addFeature(feature5)
        
        
        let line = Polyline()
        line.setLineWidth(1.0)
        line.setColor(CCColor.redColor())
        line.addVertex(GeometryPoint(fromPosx:2.346030, andY:48.851913, andZ: 0, andProj: ProjectionHelper.WSG84()))
        line.addVertex(GeometryPoint(fromPosx:-118.136604, andY:33.790271, andZ: 0, andProj: ProjectionHelper.WSG84()))
        layer.addFeature(line)
        
        let circle = Circle()
        circle.setRadius(3.0)
        circle.setBorderWidth(2.0)
        circle.setBorderColor(CCColor.yellowColor())
        circle.setColor(CCColor.redColor())
        circle.location = GeometryPoint(fromPosx: -118.136604, andY:33.790271, andZ: 0, andProj: ProjectionHelper.WSG84())
        layer.addFeature(circle);
        
        let line2 = Polyline()
        line2.setLineWidth(1.0)
        line2.setColor(CCColor.redColor())
        line2.addVertex(GeometryPoint(fromPosx: 2.346030, andY:48.851913, andZ: 0, andProj: ProjectionHelper.WSG84()))
        line2.addVertex(GeometryPoint(fromPosx:-117.157433, andY:33.154932, andZ: 0, andProj: ProjectionHelper.WSG84()))
        layer.addFeature(line2)
        
        
        let line3 = Polyline()
        line3.setLineWidth(1.0)
        line3.setColor(CCColor.redColor())
        line3.addVertex(GeometryPoint(fromPosx: 2.346030, andY:48.851913, andZ: 0, andProj: ProjectionHelper.WSG84()))
        line3.addVertex(GeometryPoint(fromPosx:-71.245136, andY:46.795288, andZ: 0, andProj: ProjectionHelper.WSG84()))
        layer.addFeature(line3)
        
        
        let circle2 = Circle()
        circle2.setRadius(3.0)
        circle2.setBorderWidth(2.0)
        circle2.setBorderColor(CCColor.yellowColor())
        circle2.setColor(CCColor.redColor())
        circle2.location = GeometryPoint(fromPosx:-71.245136, andY:46.795288, andZ: 0, andProj: ProjectionHelper.WSG84())
        layer.addFeature(circle2);
    }
    
    func addTestExtension()
    {
        var filePath = NSBundle.mainBundle().pathForResource("Archive", ofType: "zip")
        var data = NSFileManager.defaultManager().contentsAtPath(filePath!)
        
        var base64Str = data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
        
        filePath = NSBundle.mainBundle().pathForResource("test", ofType: "js")
        data = NSFileManager.defaultManager().contentsAtPath(filePath!)
        let script = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        jscontext.exceptionHandler = {(context : JSContext!, val : JSValue!) -> Void in
            println(val.description)
        }
        
        
        var re = self.jscontext.evaluateScript(script! as String)
        
        
        //
//        println("\(re.toBool()), \(re.description)");
        
        
//        re = self.jscontext.evaluateScript("fileChanged(\"\(base64Str!)\");")
//
//        
//        filePath = NSBundle.mainBundle().pathForResource("chat", ofType: "zip")
//        data = NSFileManager.defaultManager().contentsAtPath(filePath!)
//        base64Str = data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
//        re = self.jscontext.evaluateScript("fileChanged(\"\(base64Str!)\");")
//
//        filePath = NSBundle.mainBundle().pathForResource("chat1", ofType: "zip")
//        data = NSFileManager.defaultManager().contentsAtPath(filePath!)
//        base64Str = data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
//        re = self.jscontext.evaluateScript("fileChanged(\"\(base64Str!)\");")
//        self.jscontext.evaluateScript(base64Str)
        
        //
        
    }
    
    func forwardLastEvent()
    {
        let view:CCGLView = self.view as! CCGLView
        let tapDetect:TapDetectingWindow = UIApplication.sharedApplication().delegate?.window as! TapDetectingWindow
        
//        for touch in tapDetect.lastEvent.allTouches()?.allObjects as [UITouch]
//        {
//            switch touch.phase {
//            case UITouchPhase.Began:
//                view.touchesBegan(tapDetect.lastEvent.allTouches()!, withEvent:tapDetect.lastEvent)
//            case UITouchPhase.Moved:
//                view.touchesMoved(tapDetect.lastEvent.allTouches()!, withEvent: tapDetect.lastEvent)
//            case UITouchPhase.Ended:
//                view.touchesEnded(tapDetect.lastEvent.allTouches()!, withEvent: tapDetect.lastEvent)
//            case UITouchPhase.Cancelled:
//                view.touchesCancelled(tapDetect.lastEvent.allTouches(), withEvent: tapDetect.lastEvent)
//            default:
//                return
//            }
//        }
        
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func setupExtensions()
    {
        webView = UIWebView()
        pangesture = UIPanGestureRecognizer(target: self, action: "didPan:")
        pangesture.delegate = self
        pinchGesture = UIPinchGestureRecognizer(target: self, action: "didPinch:")
        pinchGesture.delegate = self
        
        webView.delegate = self
        self.jscontext = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as! JSContext
        
        var block : @objc_block (NSString!) -> Void = {
            (string : NSString!) -> Void in
            println("\(string)")
        }
        jscontext.setObject(unsafeBitCast(block, AnyObject.self), forKeyedSubscript: "log")
        
        jscontext.exceptionHandler = {(context : JSContext!, val : JSValue!) -> Void in
            println(val.description)
        }
        
        var block2 : @objc_block () -> Void = {
            () -> Void in
            self.forwardLastEvent()
        }
        
        jscontext.setObject(unsafeBitCast(block2, AnyObject.self), forKeyedSubscript: "touchBeganNative")
        
        jscontext.setObject(unsafeBitCast(block2, AnyObject.self), forKeyedSubscript: "touchMovedNative")
        
        jscontext.setObject(unsafeBitCast(block2, AnyObject.self), forKeyedSubscript: "touchEndedNative")
        
        jscontext.setObject(unsafeBitCast(block2, AnyObject.self), forKeyedSubscript: "touchCancelNative")
        
        for toload in scriptToLoad
        {
            
            let filePath = NSBundle.mainBundle().pathForResource(toload, ofType: "js")
            let data = NSFileManager.defaultManager().contentsAtPath(filePath!)
            let script = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            let re = self.jscontext.evaluateScript(script! as String)
            if (self.jscontext.exception != nil)
            {
                println(self.jscontext.exception.description)
            }
        }
        
        self.webView.multipleTouchEnabled = true
        let scriptTouch = "document.body.ontouchstart = function(event) {\ntouchBeganNative()\n};\n" + "document.body.ontouchmove = function(event) {\ntouchMovedNative()\n};\n" +
            "document.body.ontouchend = function(event) {\ntouchEndedNative()\n};\n" +
            "document.body.ontouchcancel = function(event) {\ntouchCancelledNative()\n};\n"
        self.jscontext.evaluateScript(scriptTouch)
        println(scriptTouch)
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
        let vc = self.storyboardCG?.instantiateViewControllerWithIdentifier("mainNavigation")! as! UIViewController
        self.navigationController?.presentViewController(vc, animated: true, completion: { () -> Void in
            
        })
    }
    func pressStore()
    {
        let vc = self.storyboardCG?.instantiateViewControllerWithIdentifier("storeNavigation")! as! UIViewController
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
