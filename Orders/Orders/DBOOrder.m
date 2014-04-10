//
//  DBOOrder.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBOOrder.h"
#import "DBOProduct.h"
#import "DBOAppDelegate.h"
#import "DBOException.h"

static NSString * const kOrdersURL =
    @"https://my.deal.by/cabinet/export_orders/xml/31036?hash_tag=0ecc3ed1de227f51bf44ca80ae7abf6b";

@implementation DBOOrder

@synthesize products = _products;

@synthesize customerName = _customerName;
@synthesize company = _company;
@synthesize phone = _phone;
@synthesize email = _email;
@synthesize address = _address;
@synthesize index = _index;
@synthesize paymentType = _paymentType;
@synthesize deliveryType = _deliveryType;
@synthesize deliveryCost = _deliveryCost;
@synthesize payerComment = _payerComment;
@synthesize salesComment = _salesComment;
@synthesize state = _state;
@synthesize createdAt = _createdAt;

-(id)initWithXMLElement:(CXMLElement *)XMLItem
{
    if (self = [super initWithXMLElement:XMLItem])
    {
        self.state = [XMLItem valueForAttribute:@"state"];
        
        NSDateFormatter *dateParser = [[NSDateFormatter alloc] init];
        [dateParser setDateFormat:@"dd.MM.yy HH:mm"];
        self.createdAt = [dateParser dateFromString:[XMLItem valueForFieldName:@"date"]];
        
        self.customerName = [XMLItem valueForFieldName:@"name"];
        self.company = [XMLItem valueForFieldName:@"company"];
        self.phone = [XMLItem valueForFieldName:@"phone"];
        self.email = [XMLItem valueForFieldName:@"email"];
        self.address = [XMLItem valueForFieldName:@"address"];
        self.index = [XMLItem valueForFieldName:@"index"];
        self.paymentType = [XMLItem valueForFieldName:@"paymentType"];
        self.deliveryType = [XMLItem valueForFieldName:@"deliveryType"];
        self.deliveryCost = [[XMLItem valueForFieldName:@"deliveryCost"] floatValue];
        self.payerComment = [XMLItem valueForFieldName:@"payercomment"];
        self.salesComment = [XMLItem valueForFieldName:@"salescomment"];
        self.price = [[XMLItem valueForFieldName:@"priceUAH"] floatValue];
        
        NSArray *prodItems = [XMLItem nodesForXPath:@"items/item" error:NULL];
        
        NSMutableArray *tmpProducts = [NSMutableArray arrayWithCapacity:prodItems.count];
        for (CXMLElement *productItem in prodItems)
        {
            [tmpProducts addObject:[[DBOProduct alloc] initWithXMLElement:productItem]];
        }
        
        self.products = [NSArray arrayWithArray:tmpProducts];
    }
    
    return self;
}

-(BOOL)match:(NSString *)term
{
    if ([term intValue] == self.ID) return YES;
    if (NSNotFound != [self.customerName rangeOfString:term].location) return YES;
    if ([self.phone isEqualToString:term]) return YES;
    
    for (DBOProduct *item in self.products)
    {
        if ([item match:term]) return YES;
    }
    
    return [super match:term];
}

+(void)findAll:(OrdersCompletionBlock)completion
{
    NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL URLWithString:kOrdersURL]];
    
    [NSURLConnection
     sendAsynchronousRequest:rq
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *loadError)
     {
         @try
         {
             if (loadError)
                 [DBOException raiseWithError:loadError];
             
             NSError *parseError = nil;
#if 1
             CXMLDocument *xml = [[CXMLDocument alloc] initWithData:data options:0 error:&parseError];
             if (parseError)
                 [DBOException raiseWithError:parseError];
#else
             CXMLDocument *xml = [[CXMLDocument alloc]
                                  initWithXMLString:@"<orders><order id=\"1\"></order><order id=\"2\"></order></orders>"
                                  options:0
                                  error:&parseError];
             if (parseError)
                 [DBOException raiseWithError:parseError];
             
#endif
             
             NSError *findError = nil;
             NSArray *orderNodes = [xml nodesForXPath:@"//order" error:&findError];
             if (findError)
                 [DBOException raiseWithError:findError];
             
             NSMutableArray *tmpOrders = [NSMutableArray arrayWithCapacity:orderNodes.count];
             for (CXMLElement *orderNode in orderNodes)
             {
                 DBOOrder *order = [[DBOOrder alloc] initWithXMLElement:orderNode];
                 [tmpOrders addObject:order];
             }
             
             completion(YES, [NSArray arrayWithArray:tmpOrders]);
         }
         @catch (NSException *exception)
         {
             NSLog(@"%@\n%@", exception.name, exception.reason);
             completion(NO, nil);
         }
         @catch (...)
         {
             completion(NO, nil);
         }
     }];
}

@end
