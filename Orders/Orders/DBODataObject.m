//
//  DBODataObject.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBODataObject.h"

@implementation DBODataObject

@synthesize ID = _ID;

-(id)initWithXMLElement:(CXMLElement*)XMLItem
{
    if (self = [super init])
    {
        NSString *idValue = [[XMLItem attributeForName:@"id"] stringValue];
        self.ID = [idValue intValue];
    }
    
    return self;
}

-(BOOL)match:(NSString*)term
{
    return NO;
}

@end
