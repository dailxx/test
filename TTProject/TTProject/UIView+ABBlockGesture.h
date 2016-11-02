//
//  UIView+ABBlockGesture.h
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ABGestureActionBlock)(UIGestureRecognizer *gestureRecognizer);

@interface UIView (ABBlockGesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)ab_addTapActionWithBlock:(ABGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)ab_addLongPressActionWithBlock:(ABGestureActionBlock)block;
@end
