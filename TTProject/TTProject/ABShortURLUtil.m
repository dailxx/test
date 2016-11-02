//
//  ABShortURLUtil.m
//  TTProject
//
//  Created by 张志恒 on 16/9/6.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABShortURLUtil.h"

@implementation ABShortURLUtil
static const char shorURLEncodingTable[62]
= "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

+ (NSString *)shortURL:(NSString *)longURL
{
    return [self shortURL:longURL wikeKey:nil];
}

+ (NSString *)shortURL:(NSString *)longURL wikeKey:(NSString *)key
{
    if (longURL.length == 0) return nil;
    if (key.length > 0) {
        longURL = [NSString stringWithFormat:@"%@%@", key, longURL];
    }
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:4];
    NSString *md5URL = longURL.ab_md5String;
    for (NSInteger i = 0; i < 4; i++) {
        NSString *hexStr = [md5URL substringWithRange:NSMakeRange(i*8, 8)];
        
        unsigned int result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexStr];
        [scanner scanHexInt:&result];
        
        result &= 0x3FFFFFFF;
        NSMutableString *string = [NSMutableString string];
        for (NSInteger j = 0; j < 6; j++) {
            [string appendFormat:@"%c", shorURLEncodingTable[result & 0x0000003D]];
            result >>= 5;
        }
        
        [resultArray addObject:string];
    }
    
    return [resultArray objectAtIndex:arc4random_uniform(4)];
}

@end
