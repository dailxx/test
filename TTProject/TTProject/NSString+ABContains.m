//
//  NSString+ABContains.m
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "NSString+ABContains.h"

@implementation NSString (ABContains)

- (BOOL)ab_containsString:(NSString *)string
{
    if (!string) return NO;
    
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:string];
    } else {
        return [self rangeOfString:string].location != NSNotFound;
    }
}

- (BOOL)ab_containsCharacterSet:(NSCharacterSet *)set
{
    if (!set) return NO;
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

- (BOOL)ab_isContainChinese
{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

@end
