//
//  DBOOrderDetailsCell.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBOOrderDetailsCell.h"
#import "DBOOrder.h"

@implementation DBOOrderDetailsCell

@synthesize IDLabel = _IDLabel;
@synthesize customerLabel = _customerLabel;
@synthesize dateLabel = _dateLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize emailLabel = _emailLabel;
@synthesize addressLabel = _addressLabel;
@synthesize companyLabel = _companyLabel;

@synthesize order = _order;

-(void)setOrder:(DBOOrder *)order
{
    if (order != _order)
    {
        _order = order;
    }
    
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    self.IDLabel.text = [NSString stringWithFormat:@"%@ %i",
                         NSLocalizedString(@"Order number", @"Order number"), self.order.ID];
    
    self.customerLabel.text = [NSString stringWithFormat:@"%@ %@",
                         NSLocalizedString(@"Customer", @"Customer"), self.order.customerName];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yy HH:mm"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",
                           NSLocalizedString(@"Date", @"Date"), [formatter stringFromDate:self.order.createdAt]];
    
    self.phoneLabel.text = [NSString stringWithFormat:@"%@ %@",
                            NSLocalizedString(@"Phone", @"Phone"), self.order.phone];
    
    self.emailLabel.text = [NSString stringWithFormat:@"Email %@", self.order.email];
    
    NSString *address = self.order.address;
    if (!address)
        address = NSLocalizedString(@"unknown", @"unknown");
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",
                              NSLocalizedString(@"Delivery address", @"Delivery address"), address];
    
    NSString *company = self.order.company;
    if (!company)
        company = @"-";
    
    self.companyLabel.text = [NSString stringWithFormat:@"%@ %@",
                              NSLocalizedString(@"Company", @"Company"), company];
}

+(DBOOrderDetailsCell*)cell
{
    return [[[NSBundle mainBundle]
             loadNibNamed:@"DBOOrderDetailsCell" owner:nil options:nil] objectAtIndex:0];
}

@end
