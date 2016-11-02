//
//  NSString+ABReverse.m
//  TTProject
//
//  Created by 张志恒 on 16/8/30.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "NSString+ABReverse.h"

@implementation NSString (ABReverse)

+ (NSString *)ab_reverseString:(NSString *)strSrc
{
    NSMutableString *reversedString = [NSMutableString stringWithCapacity:strSrc.length];
    
    [strSrc enumerateSubstringsInRange:NSMakeRange(0, strSrc.length)
                               options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                [reversedString appendString:substring];
                            }];
    
    return reversedString;
}

@end
