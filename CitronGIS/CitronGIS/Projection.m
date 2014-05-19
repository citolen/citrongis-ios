//
//  Projection.m
//  CitronGIS
//
//  Created by Charly DELAROCHE on 13/05/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

#import "Projection.h"

@implementation Projection

+(Projection*)projectionWithName:(NSString*)name
{
    Projection *re = [[Projection alloc] init];
    
    if ((re.proj = pj_init_plus(name.UTF8String)) == NULL)
    {
        @throw ([NSException exceptionWithName:@"crs_error" reason:@"Invalid projection" userInfo:nil]);
    }
    return re;
}

+(Projection*)projectionWithProj:(projPJ*)proj
{
    Projection *re = [[Projection alloc] init];
    
    re.proj = proj;
    
    return re;
}

-(NSString*)description
{
    return [NSString stringWithUTF8String:pj_get_def(_proj, 0)];    
}

-(void)dealloc
{
    pj_dalloc(_proj);
}

@end
