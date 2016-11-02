//
//  UIAlertView+ABBlock.h
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (ABBlock)<UIAlertViewDelegate>

- (void)ab_showWithCompleteBlock:(void(^)(NSInteger buttonIndex))block;

@end
