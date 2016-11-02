//
//  NSArray+ABNetworkingAddtions.m
//  TTProject
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "NSArray+ABNetworkingAddtions.h"

@implementation NSArray (ABNetworkingAddtions)

/** 字母排序之后形成的参数字符串 */
- (NSString *)AB_paramsString
{
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    return [sortedParams componentsJoinedByString:@"&"];
}

/** 数组变json */
- (NSString *)AB_jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
