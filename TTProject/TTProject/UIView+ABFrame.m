//
//  UIView+ABFrame.m
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "UIView+ABFrame.h"

@implementation UIView (ABFrame)

- (CGFloat)ab_top
{
    return self.frame.origin.y;
}

- (void)setAb_top:(CGFloat)ab_top
{
    CGRect frame = self.frame;
    frame.origin.y = ab_top;
    self.frame = frame;
}

- (CGFloat)ab_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setAb_bottom:(CGFloat)ab_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = ab_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)ab_left
{
    return self.frame.origin.x;
}

- (void)setAb_left:(CGFloat)ab_left
{
    CGRect frame = self.frame;
    frame.origin.x = ab_left;
    self.frame = frame;
}

- (CGFloat)ab_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setAb_right:(CGFloat)ab_right
{
    CGRect frame = self.frame;
    frame.origin.x = ab_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)ab_width
{
    return self.frame.size.width;
}

- (void)setAb_width:(CGFloat)ab_width
{
    CGRect frame = self.frame;
    frame.size.width = ab_width;
    self.frame = frame;
}

- (CGFloat)ab_height
{
    return self.frame.size.height;
}

- (void)setAb_height:(CGFloat)ab_height
{
    CGRect frame = self.frame;
    frame.size.height = ab_height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)ab_origin
{
    return self.frame.origin;
}

- (void)setAb_origin:(CGPoint)ab_origin
{
    CGRect frame = self.frame;
    frame.origin = ab_origin;
    self.frame = frame;
}

- (CGSize)ab_size
{
    return self.frame.size;
}

- (void)setAb_size:(CGSize)ab_size
{
    CGRect frame = self.frame;
    frame.size = ab_size;
    self.frame = frame;
}

#pragma mark - Shortcuts for positions

- (CGFloat)ab_centerX
{
    return self.center.x;
}

- (void)setAb_centerX:(CGFloat)ab_centerX
{
    self.center = CGPointMake(ab_centerX, self.center.y);
}

- (CGFloat)ab_centerY
{
    return self.center.y;
}

- (void)setAb_centerY:(CGFloat)ab_centerY
{
    self.center = CGPointMake(self.center.x, ab_centerY);
}

@end
