//
//  DBOOrderListCell.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBOOrder;

@interface DBOOrderListCell : UITableViewCell

@property(nonatomic, strong) DBOOrder *order;

@property(nonatomic, strong) IBOutlet UILabel *IDLabel;
@property(nonatomic, strong) IBOutlet UILabel *dateLabel;
@property(nonatomic, strong) IBOutlet UILabel *priceLabel;

+(DBOOrderListCell*)cell;

@end
