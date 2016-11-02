//
//  UIView+ABBlockGesture.m
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "UIView+ABBlockGesture.h"
#import <objc/runtime.h>

static char ab_kActionHandlerTapBlockKey;
static char ab_kActionHandlerTapGestureKey;
static char ab_kActionHandlerLongPressBlockKey;
static char ab_kActionHandlerLongPressGestureKey;

@implementation UIView (ABBlockGesture)

- (void)ab_addTapActionWithBlock:(ABGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &ab_kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ab_handleActionFroTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &ab_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &ab_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)ab_handleActionFroTapGesture:(UITapGestureRecognizer *)gesture
{
    ABGestureActionBlock block = objc_getAssociatedObject(self, &ab_kActionHandlerTapBlockKey);
    if (block) {
        block(gesture);
    }
}

- (void)ab_addLongPressActionWithBlock:(ABGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &ab_kActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(ab_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &ab_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &ab_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)ab_handleActionForLongPressGesture:(UILongPressGestureRecognizer *)gesture
{
    ABGestureActionBlock block = objc_getAssociatedObject(self, &ab_kActionHandlerLongPressBlockKey);
    if (block) {
        block(gesture);
    }
}

@end
