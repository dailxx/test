//
//  NSString+ABTrims.h
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABTrims)
/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)ab_trimmingWhitespace;
/**
 *  @brief  去除换行
 *
 *  @return 去除换行后的字符串
 */
- (NSString *)ab_trimmingNewlines;
/**
 *  @brief  去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)ab_trimmingWhitespaceAndNewlines;

@end
