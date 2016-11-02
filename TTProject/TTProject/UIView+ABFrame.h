//
//  UIView+ABFrame.h
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ABFrame)

// shortcuts for frame properties
@property (nonatomic, assign) CGPoint ab_origin;
@property (nonatomic, assign) CGSize ab_size;

// shortcuts for positions
@property (nonatomic) CGFloat ab_centerX;
@property (nonatomic) CGFloat ab_centerY;



@property (nonatomic) CGFloat ab_top;
@property (nonatomic) CGFloat ab_bottom;
@property (nonatomic) CGFloat ab_left;
@property (nonatomic) CGFloat ab_right;

@property (nonatomic) CGFloat ab_width;
@property (nonatomic) CGFloat ab_height;

@end
