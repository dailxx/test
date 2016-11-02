//
//  UIImage+ABAlpha.m
//  TTProject
//
//  Created by 张志恒 on 16/8/31.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "UIImage+ABAlpha.h"

@implementation UIImage (ABAlpha)

- (BOOL)ab_hasAlphaChannel
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

@end
