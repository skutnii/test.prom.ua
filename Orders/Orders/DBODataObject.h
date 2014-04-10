//
//  DBODataObject.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"
#import "CXMLNode+DBOParseHelpers.h"
#import "CXMLElement+DBOParseHelpers.h"

@interface DBODataObject : NSObject

@property(nonatomic, assign) int ID;
@property(nonatomic, assign) float price;

//Designated initializer
-(id)initWithXMLElement:(CXMLElement*)XMLItem;

-(BOOL)match:(NSString*)term;

@end
