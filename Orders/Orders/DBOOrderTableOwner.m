//
//  DBOOrderDataSource.m
//  Orders
//
//  Created by Serge Kutny on 4/11/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBOOrderTableOwner.h"
#import "DBOOrder.h"
#import "DBOOrderDetailsCell.h"
#import "DBOProductInfoCell.h"
#import "DBOProduct.h"
#import "UIImage+WebLoad.h"

@implementation DBOOrderTableOwner

@synthesize contentView = _contentView;
@synthesize order = _order;

-(void)setOrder:(DBOOrder *)order
{
    if (_order != order)
    {
        _order = order;
        [self.contentView reloadData];
    }
}

-(void)setContentView:(UITableView *)contentView
{
    if (_contentView != contentView)
    {
        _contentView = contentView;
        _contentView.delegate = self;
        _contentView.dataSource = self;
    }
}

#pragma mark Table View Management

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return self.order.products.count;
        case 2:
            return 1;
        default:
            return 0;
    }
}

-(UITableViewCell*)orderInfoCell
{
    DBOOrderDetailsCell *cell = [self.contentView dequeueReusableCellWithIdentifier:@"OrderDetails"];
    if (!cell)
    {
        cell = [DBOOrderDetailsCell cell];
    }
    
    cell.order = self.order;
    return cell;
}

-(UITableViewCell*)productCellForIndex:(NSInteger)index
{
    DBOProductInfoCell *cell = [self.contentView dequeueReusableCellWithIdentifier:@"Product"];
    if (!cell)
    {
        cell = [DBOProductInfoCell cell];
    }
    
    DBOProduct *product = [self.order.products objectAtIndex:index];
    cell.product = product;
    
    if (!product.icon)
    {
        [UIImage loadFrom:product.imageLink completion:^(BOOL success, UIImage *icon) {
            product.icon = icon;
            [self.contentView
             reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    
    return cell;
}

-(UITableViewCell*)priceCell
{
    UITableViewCell *cell = [self.contentView dequeueReusableCellWithIdentifier:@"Price"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Price"];
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:26];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%.2f %@",
                           self.order.price, NSLocalizedString(@"UAH", @"UAH")];
    return cell;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return [self orderInfoCell];
        case 1:
            return [self productCellForIndex:indexPath.row];
        case 2:
            return [self priceCell];
        default:
            return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 230;
        case 1:
            return 115;
        case 2:
            return [self priceCell].frame.size.height;
        default:
            return 0;
    }
}

@end
