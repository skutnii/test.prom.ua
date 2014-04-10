//
//  DBOViewController.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBOViewController :
    UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain) IBOutlet UITableView *ordersView;

@end
