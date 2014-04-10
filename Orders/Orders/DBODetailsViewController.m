//
//  DBODetailsViewController.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBODetailsViewController.h"
#import "DBOOrder.h"
#import "DBOProduct.h"
#import "DBOOrderDetailsCell.h"
#import "DBOProductInfoCell.h"
#import "UIImage+WebLoad.h"
#import "DBOOrderTableOwner.h"

@interface DBODetailsViewController ()

@end

@implementation DBODetailsViewController

@synthesize tableOwner = _tableOwner;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableOwner.contentView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animateTransitionForward:(BOOL)forward toOrder:(DBOOrder*)order
{
    UITableView *oldContentView = self.tableOwner.contentView;
    CGRect newTableFrame = oldContentView.frame;
    
    CGFloat shift = forward ? newTableFrame.size.width : -newTableFrame.size.width;
    
    newTableFrame.origin.x += shift;
    UITableView *newContentView = [[UITableView alloc]
                                   initWithFrame:newTableFrame style:UITableViewStylePlain];
    [self.view addSubview:newContentView];
    
    DBOOrderTableOwner *newTableOwner = [DBOOrderTableOwner new];
    newTableOwner.order = order;
    newTableOwner.contentView = newContentView;
    [newContentView reloadData];
    
    newTableFrame = oldContentView.frame;
    CGRect oldTableFrame = oldContentView.frame;
    oldTableFrame.origin.x -= shift;
    [UIView animateWithDuration:0.5
                     animations:^(void)
     {
         newContentView.frame = newTableFrame;
         oldContentView.frame = oldTableFrame;
     }
                     completion:^(BOOL finished)
     {
         [oldContentView removeFromSuperview];
         self.tableOwner = newTableOwner;
     }
     ];
}

-(IBAction)swipeLeft:(id)sender
{
    DBOOrder *order = [_delegate nextOrder];
    if (order)
    {
        [self animateTransitionForward:YES toOrder:order];
    }
}

-(IBAction)swipeRight:(id)sender
{
    DBOOrder *order = [_delegate previousOrder];
    if (order)
    {
        [self animateTransitionForward:NO toOrder:order];
    }
}

@end
