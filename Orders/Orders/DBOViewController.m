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
@synthesize ordersFinder = _ordersFinder;

-(void)setFilteredOrders:(NSArray *)filteredOrders
{
    if (filteredOrders != _filteredOrders)
    {
        _filteredOrders = filteredOrders;
        [self.ordersView reloadData];
    }
}

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
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)filterOrdersWithTerm:(NSString*)term
{
    if (!term.length)
    {
        self.filteredOrders = [NSArray arrayWithArray:self.orders];
        return;
    }
    
    NSMutableArray *tmpOrders = [NSMutableArray arrayWithCapacity:self.orders.count];
    for (DBOOrder *order in self.orders)
    {
        if ([order match:term])
            [tmpOrders addObject:order];
    }
    
    self.filteredOrders = [NSArray arrayWithArray:tmpOrders];
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

#pragma mark UITableViewDelegate

-(BOOL)tableView:(UITableView*)tableView shouldSelectRowAtIndexPath:(NSIndexPath*)iPath
{
    return YES;
}

#pragma mark UISearchBarDelegate

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [self filterOrdersWithTerm:searchBar.text];
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self filterOrdersWithTerm:searchBar.text];
    [searchBar resignFirstResponder];
}

@end
