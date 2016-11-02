//
//  NSDictionary+ABNetworkingAddtions.m
//  TTProject
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "NSDictionary+ABNetworkingAddtions.h"
#import "NSArray+ABNetworkingAddtions.h"
#import "NSString+ABNetworkingAddtions.h"

@implementation NSDictionary (ABNetworkingAddtions)

/** 网址字符串前面是没有问号的，如果用于POST，那就不用加问号，如果用于GET，就要加个问号 */
- (NSString *)AB_urlParamsStringSignature:(BOOL)isForSignature
{
    NSArray *soredArray = [self AB_transformedUrlParamsArraySignature:isForSignature];
    return [soredArray AB_jsonString];
}

/** 字典变json */
- (NSString *)AB_jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** 转义参数 */
- (NSArray *)AB_transformedUrlParamsArraySignature:(BOOL)isForSignature
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        
        if (!isForSignature) {
            obj = [obj AB_urlEncode];
        }
        
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    
    return [result sortedArrayUsingSelector:@selector(compare:)];
}

@end
