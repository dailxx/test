//
//  MyView.m
//  Autolayout
//
//  Created by 张志恒 on 16/9/26.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (CGSize)intrinsicContentSize
{
//    return [UIScreen mainScreen].bounds.size;
    return CGSizeMake(100, 100);
}

@end
