//
//  UIView+ABSnapshot.h
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ABSnapshot)

- (UIImage *)ab_snapshot;

- (UIImage *)ab_snapshotWithSize:(CGSize)size;

@end
