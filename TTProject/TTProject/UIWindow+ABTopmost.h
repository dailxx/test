//
//  UIWindow+ABTopmost.h
//  TTProject
//
//  Created by 张志恒 on 16/8/24.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (ABTopmost)
/**
 *  最上层的window
 *
 *  @return window
 */
- (UIWindow *)ab_topmostWindow;

@end
