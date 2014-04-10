//
//  DBOOrder.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBODataObject.h"

typedef void (^OrdersCompletionBlock)(BOOL success, NSArray *orders);

@interface DBOOrder : DBODataObject

@property(nonatomic, retain) NSArray *products;

@property(nonatomic, copy) NSString *state;
@property(nonatomic, copy) NSDate *createdAt;
@property(nonatomic, copy) NSString *customerName;
@property(nonatomic, copy) NSString *company;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *index;
@property(nonatomic, copy) NSString *paymentType;
@property(nonatomic, copy) NSString *deliveryType;
@property(nonatomic, assign) float deliveryCost;
@property(nonatomic, copy) NSString *payerComment;
@property(nonatomic, copy) NSString *salesComment;

+(void)findAll:(OrdersCompletionBlock)completion;

@end
