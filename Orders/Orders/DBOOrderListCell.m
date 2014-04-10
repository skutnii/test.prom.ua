//
//  DBOOrderListCell.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBOOrderListCell.h"
#import "DBOOrder.h"
#import "DBOProduct.h"

@implementation DBOOrderListCell

@synthesize IDLabel = _IDLabel;
@synthesize dateLabel = _dateLabel;
@synthesize priceLabel = _priceLabel;

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
    if ([self.order.state isEqualToString:@"new"])
    {
        self.IDLabel.textColor = [UIColor darkTextColor];
        self.IDLabel.text = [NSString stringWithFormat:@"№ %i - %@",
                             self.order.ID, self.order.customerName];
        
        self.priceLabel.textColor = [UIColor darkTextColor];
    }
    else
    {
        UIColor *labelColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        self.IDLabel.textColor = labelColor;
        self.IDLabel.text = [NSString stringWithFormat:@"%@ | № %i",
                             NSLocalizedString(self.order.state, "State"), self.order.ID];
        
        self.priceLabel.textColor = labelColor;
    }

    NSString *productName = @"";
    if (self.order.products.count)
    {
        DBOProduct *product = [self.order.products objectAtIndex:0];
        productName = product.name;
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f %@ - %@",
                            self.order.price, NSLocalizedString(@"UAH", @"UAH"), productName];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:now];
    [dayComps setHour:0];
    [dayComps setMinute:0];
    NSDate *lastMidnight = [calendar dateFromComponents:dayComps];
    
    NSDateComponents *dayDiff = [[NSDateComponents alloc] init];
    [dayDiff setDay:-1];
    NSDate *previousMidnight = [calendar dateByAddingComponents:dayDiff toDate:lastMidnight options:0];
    
    NSDate *orderDate = self.order.createdAt;
    NSDateFormatter *formatter = [NSDateFormatter new];
    if (NSOrderedDescending == [orderDate compare:lastMidnight])
    {
        [formatter setDateFormat:@"HH:mm"];
    }
    else if (NSOrderedDescending == [orderDate compare:previousMidnight])
    {
        [formatter setDateFormat:NSLocalizedString(@"Yesterday", @"Yesterday")];
    }
    else
    {
        [formatter setDateFormat:@"dd MMM"];
    }
    self.dateLabel.text = [formatter stringFromDate:orderDate];
}

+(DBOOrderListCell*)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DBOOrderListCell" owner:nil options:nil] objectAtIndex:0];
}

@end
