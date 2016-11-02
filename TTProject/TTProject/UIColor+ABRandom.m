//
//  UIColor+ABRandom.m
//  TTProject
//
//  Created by 张志恒 on 16/8/31.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "UIColor+ABRandom.h"

@implementation UIColor (ABRandom)

+ (UIColor *)ab_randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.f
                           green:arc4random_uniform(255)/255.f
                            blue:arc4random_uniform(255)/255.f
                           alpha:1.f];
}

@end
