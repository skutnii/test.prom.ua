//
//  UIImage+WebLoad.h
//  Orders
//
//  Created by Serge Kutny on 4/10/14.
//  Copyright (c) 2014 deal.by. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DBOImageLoadCompletion)(BOOL success, UIImage *image);

@interface UIImage (WebLoad)

+(void)loadFrom:(NSString *)link  completion:(DBOImageLoadCompletion)completion;

@end
