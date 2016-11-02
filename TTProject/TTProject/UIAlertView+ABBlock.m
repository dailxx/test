//
//  UIAlertView+ABBlock.m
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "UIAlertView+ABBlock.h"
#import <objc/runtime.h>

@implementation UIAlertView (ABBlock)

- (void)ab_showWithCompleteBlock:(void (^)(NSInteger))block
{
    if (block) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, @selector(ab_showWithCompleteBlock:), block, OBJC_ASSOCIATION_COPY);
        self.delegate = self;
    }
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void(^completeBlock)(NSInteger btnIndex) = objc_getAssociatedObject(self, @selector(ab_showWithCompleteBlock:));
    if (completeBlock) {
        completeBlock(buttonIndex);
    }
}

@end
