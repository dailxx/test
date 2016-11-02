//
//  NSString+ABPinyin.h
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABPinyin)
/**
 *  带音标的拼音
 */
- (NSString*)ab_pinyinWithPhoneticSymbol;
/**
 *  不带音标的拼音
 */
- (NSString*)ab_pinyin;

@end
