//
//  DBOProductInfoCell.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "DBOProductInfoCell.h"
#import "DBOProduct.h"

@implementation DBOProductInfoCell

@synthesize product = _product;

@synthesize nameLabel = _nameLabel;
@synthesize priceLabel = _priceLabel;
@synthesize totalLabel = _totalLabel;
@synthesize iconView = _iconView;

-(void)setProduct:(DBOProduct *)product
{
    if (product != _product)
    {
        _product = product;
    }
    
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    self.nameLabel.text = self.product.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f %@ | x%g",
                            self.product.price,
                            NSLocalizedString(self.product.currency, @""),
                            self.product.quantity];
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f %@",
                            self.product.price * self.product.quantity,
                            NSLocalizedString(self.product.currency, @"")];
    
    UIImage *icon = self.product.icon;
    if (!icon)
        icon = [UIImage imageNamed:@"placeholder.png"];
    self.iconView.image = icon;
}

+(DBOProductInfoCell*)cell
{
    return [[[NSBundle mainBundle]
             loadNibNamed:@"DBOProductInfoCell" owner:nil options:nil] objectAtIndex:0];
}

@end
