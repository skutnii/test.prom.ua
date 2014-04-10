//
//  DBOException.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBOException : NSException

@property(nonatomic, readonly) NSError *error;

-(id)initWithError:(NSError*)error;
+(void)raiseWithError:(NSError*)error;

@end
