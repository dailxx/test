//
//  UIWindow+ABTopmost.m
//  TTProject
//
//  Created by 张志恒 on 16/8/24.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "UIWindow+ABTopmost.h"

@implementation UIWindow (ABTopmost)

- (UIWindow *)ab_topmostWindow
{
    UIWindow *topmost;
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            topmost = window;
            break;
        }
    }
    
    return topmost;
}

@end
