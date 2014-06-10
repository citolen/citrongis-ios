//
//  CitronGISTests.m
//  CitronGISTests
//
//  Created by Charly DELAROCHE on 10/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Projection.h"
#import "CoordinatesHelper.h"
#import "GeometryPoint.h"

@interface CitronGISTests : XCTestCase

@end

@implementation CitronGISTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testCreateProjection
{
    char *srid28992 = "+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.04,49.91,465.84,-1.9848,1.7439,-9.0587,4.0772 +units=m +no_defs";
    
    Projection *proj = [Projection projectionWithName:[NSString stringWithUTF8String:srid28992]];
    XCTAssertTrue(proj != nil, @"Fail creating proj with string");
}

-(void)testTransformPoint
{
    GeometryPoint *pt = [GeometryPoint GeometryPointWithX:4.913029 andY:52.342404 andZ:0 andProjection:@"+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"];
    Projection *proj = [Projection projectionWithName:@"+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.04,49.91,465.84,-1.9848,1.7439,-9.0587,4.0772 +units=m +no_defs"];
    
    //[pt transformToProjPtr:proj];
    
    
    for (size_t i = 0; i < 100000; ++i)
    {
        [CoordinatesHelper transformTo:pt toProjPtr:proj];
    }
    XCTAssertTrue(pt != nil, @"Fail transformating point");
}

@end
