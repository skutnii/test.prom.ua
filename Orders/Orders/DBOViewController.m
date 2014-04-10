//
//  DBOViewController.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBOViewController.h"
#import "DBOOrder.h"

@interface DBOViewController ()

@property(nonatomic, retain) NSArray *orders;
@property(nonatomic, retain) NSArray *filteredOrders;

@end

@implementation DBOViewController

@synthesize orders = _orders;
@synthesize filteredOrders = _filteredOrders;
@synthesize ordersView = _ordersView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = NSLocalizedString(@"Orders", @"Orders");
    [DBOOrder findAll:^(BOOL OK, NSArray *orders){
        if (!OK)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(@"Error", @"Error")
                                  message:NSLocalizedString(@"Could not load orders", @"Could not load orders")
                                  delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"Close", @"Close")
                                  otherButtonTitles:nil];
            [alert show];
        }
        
        self.orders = orders;
        self.filteredOrders = orders;
        
        [self.ordersView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredOrders.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView
                cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Order"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Order"];
    }
    
    DBOOrder *order = [self.filteredOrders objectAtIndex:indexPath.row];
    cell.textLabel.text = order.customerName;
    
    return cell;
}

@end
