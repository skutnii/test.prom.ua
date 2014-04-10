//
//  DBODetailsViewController.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBOOrder;
@class DBODetailsViewController;
@class DBOOrderTableOwner;

@protocol DBODetailsDelegate <NSObject>

-(DBOOrder*)nextOrder;
-(DBOOrder*)previousOrder;

@end

@interface DBODetailsViewController : UIViewController

@property(nonatomic, strong) IBOutlet DBOOrderTableOwner *tableOwner;
@property(nonatomic, assign) id<DBODetailsDelegate> delegate;

-(IBAction)swipeLeft:(id)sender;
-(IBAction)swipeRight:(id)sender;

@end
