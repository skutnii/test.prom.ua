//
//  UIImage+WebLoad.m
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import "UIImage+WebLoad.h"

@implementation UIImage (WebLoad)

+(void)loadFrom:(NSString *)link  completion:(DBOImageLoadCompletion)completion
{
    NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
    [NSURLConnection sendAsynchronousRequest:rq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error)
                               {
                                   completion(NO, nil);
                               }
                               
                               completion(YES, [[UIImage alloc] initWithData:data]);
                           }];
}

@end
