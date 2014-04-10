//
//  DBOOrderDataSource.h
//  Orders
//
//  Created by Serge Kutny on 4/11/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBOOrder;

@interface DBOOrderTableOwner : NSObject<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) DBOOrder *order;
@property(nonatomic, strong) IBOutlet UITableView *contentView;

@end
