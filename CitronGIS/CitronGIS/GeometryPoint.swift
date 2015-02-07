//
//  GeometryPoint.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 30/06/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

import Foundation
import JavaScriptCore

protocol    GeometryPointExport : JSExport
{
    var mustBeSettable: Int { get set};
    
    func getSqure(fromPt pt:GeometryPoint) -> GeometryPoint
}

@objc class GeometryPoint : GeometryPointExport
{
    func getSqure(fromPt pt: GeometryPoint) -> GeometryPoint {
        pt.mustBeSettable = -1;
      return pt
    }
    var mustBeSettable: Int
    var x: Double
    var y: Double
    var z: Double
    var proj: Projection
    
    init(fromPosx x:Double, andY y:Double, andZ z:Double, andProj proj:Projection)
    {
        self.proj = proj
        self.x = x
        self.y = y
        self.z = z
        self.mustBeSettable = 0
    }
    @objc init()
    {
        self.proj = Projection(fromName:"+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.04,49.91,465.84,-1.9848,1.7439,-9.0587,4.0772 +units=m +no_defs")
        self.x = 0;
        self.y = 0;
        self.z = 0;
        self.mustBeSettable = 0
    }
    func pointWithProj(fromProj proj:Projection) -> GeometryPoint
    {
        var p = GeometryPoint (fromPosx: x, andY: y, andZ: z, andProj: self.proj)
        p.transformToProj(fromProj: proj)
        return p
    }
    func transformToProj(fromProj proj:Projection)
    {
        var re = pj_transform(self.proj.projection, proj.projection, 1, 0, &x, &y, &z)
        self.proj = proj
    }
    var description: String {
        return "\(x)-\(y)-\(z)-\(proj)"
    }
    @objc class func testJava()
    {
        let jscontext: JSContext = JSContext()
        let jscode = "function sqrtOf(obj) {return MyObject.getSqure(obj);}";
//        jscontext.setObject(GeometryPoint.self, forKeyedSubscript: "MyObject")
        jscontext.evaluateScript(jscode)
        
        let testPt = GeometryPoint(fromPosx: 0, andY: 0, andZ: 0, andProj: Projection(fromName:"+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.04,49.91,465.84,-1.9848,1.7439,-9.0587,4.0772 +units=m +no_defs"))
        
        testPt.mustBeSettable = 0
        
        let fonc = jscontext.objectForKeyedSubscript("sqrtOf")
        let val = fonc.callWithArguments([testPt])
        
        let jsRe:GeometryPoint = val.toObject() as GeometryPoint
        
        println("\(jsRe.mustBeSettable)")
    }
}
