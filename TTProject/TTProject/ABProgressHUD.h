//
//  ABProgressHUD.h
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+ABHex.h"

typedef void(^ABProgressHUDDimissCompletionBlock)();

@interface ABProgressHUD : UIView

+ (void)show;
+ (void)dimiss;
+ (void)dimissWithDelay:(NSTimeInterval)delay;
+ (void)dismissWithCompletion:(ABProgressHUDDimissCompletionBlock)completion;
+ (void)dismissWithDelay:(NSTimeInterval)delay
              completion:(ABProgressHUDDimissCompletionBlock)completion;

@end

