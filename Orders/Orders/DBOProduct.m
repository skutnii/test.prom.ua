//
//  DBOProduct.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBOProduct.h"

@implementation DBOProduct

@synthesize name = _name;
@synthesize sku = _sku;
@synthesize quantity = _quantity;
@synthesize currency = _currency;
@synthesize imageLink = _imageLink;
@synthesize productLink = _productLink;

-(id)initWithXMLElement:(CXMLElement *)XMLItem
{
    if (self = [super initWithXMLElement:XMLItem])
    {
        self.name = [XMLItem valueForFieldName:@"name"];
        self.sku = [XMLItem valueForFieldName:@"sku"];
        self.quantity = [[XMLItem valueForFieldName:@"quantity"] floatValue];
        self.currency = [XMLItem valueForFieldName:@"currency"];
        self.imageLink = [XMLItem valueForFieldName:@"image"];
        self.productLink = [XMLItem valueForFieldName:@"url"];
    }
    
    return self;
}

- (BOOL)match:(NSString *)term
{
    if ([self.name isEqualToString:term] || [self.sku isEqualToString:term]) return YES;
    
    return [super match:term];
}

@end
