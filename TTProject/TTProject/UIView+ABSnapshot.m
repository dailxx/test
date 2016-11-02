//
//  UIView+ABSnapshot.m
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "UIView+ABSnapshot.h"

@implementation UIView (ABSnapshot)

- (UIImage *)ab_snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, 0);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)ab_snapshotWithSize:(CGSize)size
{
    return nil;
}

@end
