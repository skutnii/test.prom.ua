//
//  CXMLNode+DBOParseHelpers.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "CXMLNode+DBOParseHelpers.h"
#import "DBOException.h"

@implementation CXMLNode (DBOParseHelpers)

-(NSString*)valueForFieldName:(NSString*)name
{
    NSError *findError = nil;
    CXMLNode *field = [self nodeForXPath:name error:&findError];
    if (findError)
        [DBOException raiseWithError:findError];
    
    return [field stringValue];
}

@end
