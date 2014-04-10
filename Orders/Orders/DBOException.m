//
//  DBOException.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBOException.h"

@implementation DBOException

@synthesize error = _error;

-(id)initWithError:(NSError *)error
{
    if (self = [super
                initWithName:[NSString stringWithFormat:@"%@ %i", error.domain, error.code]
                reason:[error localizedDescription]
                userInfo:error.userInfo])
    {
        _error = [error copy];
    }
    
    return self;
}

+(void)raiseWithError:(NSError *)error
{
    [[[self alloc] initWithError:error] raise];
}

@end
