//
//  CXMLElement+DBOParseHelpers.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "CXMLElement+DBOParseHelpers.h"

@implementation CXMLElement (DBOParseHelpers)

-(NSString*)valueForAttribute:(NSString*)attr
{
    return [[self attributeForName:attr] stringValue];
}

@end
