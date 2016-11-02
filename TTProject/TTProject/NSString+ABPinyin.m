//
//  NSString+ABPinyin.m
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "NSString+ABPinyin.h"

@implementation NSString (ABPinyin)

- (NSString *)ab_pinyinWithPhoneticSymbol
{
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSString *)ab_pinyin
{
    NSMutableString *pinyin = [NSMutableString stringWithString:[self ab_pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

@end
