//
//  DBOProductInfoCell.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBOProduct;

@interface DBOProductInfoCell : UITableViewCell

@property(nonatomic, strong) DBOProduct *product;

@property(nonatomic, strong) IBOutlet UILabel *nameLabel;
@property(nonatomic, strong) IBOutlet UILabel *priceLabel;
@property(nonatomic, strong) IBOutlet UILabel *totalLabel;
@property(nonatomic, strong) IBOutlet UIImageView *iconView;

+(DBOProductInfoCell*)cell;

@end
