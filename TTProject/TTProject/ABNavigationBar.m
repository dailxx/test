//
//  ABNavigationBar.m
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABNavigationBar.h"

@implementation ABNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake((self.bounds.size.width-220.f)/2, 12.f, 220.f, 20.f);
        _titleLabel.font = [UIFont boldSystemFontOfSize:19.f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
