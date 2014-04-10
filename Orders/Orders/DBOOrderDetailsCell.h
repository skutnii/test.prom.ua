//
//  DBOOrderDetailsCell.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBOOrder;

@interface DBOOrderDetailsCell : UITableViewCell

@property(nonatomic, strong) DBOOrder *order;

@property(nonatomic, strong) IBOutlet UILabel *IDLabel;
@property(nonatomic, strong) IBOutlet UILabel *customerLabel;
@property(nonatomic, strong) IBOutlet UILabel *dateLabel;
@property(nonatomic, strong) IBOutlet UILabel *phoneLabel;
@property(nonatomic, strong) IBOutlet UILabel *emailLabel;
@property(nonatomic, strong) IBOutlet UILabel *addressLabel;
@property(nonatomic, strong) IBOutlet UILabel *companyLabel;

+(DBOOrderDetailsCell*)cell;

@end
