//
//  NSURLRequest+ABNetworkingAddtions.m
//  TTProject
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "NSURLRequest+ABNetworkingAddtions.h"
#import <objc/runtime.h>

@implementation NSURLRequest (ABNetworkingAddtions)

- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, @selector(requestParams), requestParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, @selector(requestParams));
}

@end
