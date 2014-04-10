//
//  DBOProduct.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBODataObject.h"

@interface DBOProduct : DBODataObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *sku;
@property(nonatomic, assign) float quantity;
@property(nonatomic, copy) NSString *currency;
@property(nonatomic, copy) NSString *imageLink;
@property(nonatomic, copy) NSString *productLink;

@end
