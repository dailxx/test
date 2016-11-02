//
//  UIWindow+ABHierarchy.m
//  TTProject
//
//  Created by 张志恒 on 16/8/24.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "UIWindow+ABHierarchy.h"

@implementation UIWindow (ABHierarchy)

- (UIViewController *)ab_topMostController
{
    UIViewController *topController = [self rootViewController];
    // Getting topMost ViewController
    while ([topController presentedViewController]) {
        topController = [topController presentedViewController];
    }
    
    // Returning topMost ViewController
    return topController;
}

- (UIViewController *)ab_currentViewController
{
    UIViewController *currentViewController = [self ab_topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController]) {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    }
    
    return currentViewController;
}

@end
























