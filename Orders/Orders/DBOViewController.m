//
//  DBOViewController.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBOViewController.h"
#import "DBOOrder.h"
#import "DBOOrderListCell.h"
#import "DBOOrderTableOwner.h"

@interface DBOViewController ()

@property(nonatomic, retain) NSArray *orders;
@property(nonatomic, retain) NSArray *filteredOrders;
@property(nonatomic, assign) NSInteger currentSelection;

@end

@implementation DBOViewController

@synthesize orders = _orders;
@synthesize filteredOrders = _filteredOrders;
@synthesize ordersView = _ordersView;
@synthesize ordersFinder = _ordersFinder;
@synthesize currentSelection = _currentSelection;

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
    DBOOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Order"];
    if (!cell)
    {
        cell = [DBOOrderListCell cell];
    }
    
    DBOOrder *order = [self.filteredOrders objectAtIndex:indexPath.row];
    cell.order = order;
    
    return cell;
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}

-(NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(NSIndexPath*)iPath
{
    self.currentSelection = iPath.row;
    
    DBODetailsViewController *detailsController = [DBODetailsViewController new];
    detailsController.delegate = self;
    [detailsController view];
    detailsController.tableOwner.order = [self.filteredOrders objectAtIndex:iPath.row];
    [self.navigationController pushViewController:detailsController animated:YES];
    
    return iPath;
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
    [self filterOrdersWithTerm:nil];
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self filterOrdersWithTerm:searchBar.text];
    [searchBar resignFirstResponder];
}

#pragma mark DBODetailsDelegate

-(DBOOrder*)nextOrder
{
    NSInteger nextOrderIndex = self.currentSelection + 1;
    if (nextOrderIndex < self.filteredOrders.count)
    {
        self.currentSelection = nextOrderIndex;
        return [self.filteredOrders objectAtIndex:nextOrderIndex];
    }
    
    return nil;
}

-(DBOOrder*)previousOrder
{
    NSInteger previousOrderIndex = self.currentSelection - 1;
    if (previousOrderIndex >= 0)
    {
        self.currentSelection = previousOrderIndex;
        return [self.filteredOrders objectAtIndex:previousOrderIndex];
    }
    
    return nil;
}

@end
